class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_only_user!, only: :create
  before_action :set_cart
  before_action :set_order, only: [:show, :update, :checkout]
  before_action :set_order_status_options, only: [:show, :update]
  before_action :set_orders, only: :index

  def index
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Order Summary"
      end
    end
  end

  def create
    @order = current_user.orders.new(order_params)
    @order.build_from_cart(@cart)

    process_order(@order, params[:stripeToken]) do
      @cart.destroy
    end
  end

  def checkout
    render 'carts/checkout'
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Order ##{@order.id}"
      end
    end
  end

  def update
    if current_user.is_admin?
      if @order.is_payment_failed?
        flash[:notice] = 'This order is not paid yet.'
        render :show
      elsif @order.update(update_order_params)
        flash[:notice] = 'Order Updated'
        redirect_to order_path(@order)
      else
        render :show
      end
    else
      process_order(@order, params[:stripeToken])
    end
  end

  private

  def set_orders
    @q = Order.ransack(params[:q])
    if current_user.is_admin?
      if request.format.pdf?
        @orders = @q.result(distinct: true).order(created_at: :desc)
      else
        @orders = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(5)
      end
    else
      @orders = @q.result(distinct: true).where(user: current_user).order(created_at: :desc).page(params[:page]).per(5)
    end
  end

  def set_order_status_options
    @order_status_options = Order::STATUSES
  end

  def update_order_params
    params.require(:order).permit(:shipping_number, :status)
  end

  def order_params
    params.require(:order).permit(:shipping_vendor, address_attributes: [:province, :city,:subdistrict,:contact,:detail])
  end

  def set_order
    if current_user.is_admin?
      @order = Order.find(params[:id])
    else
      @order = current_user.orders.find(params[:id])
    end
  end

  def process_order(order, stripe_token)
    if order.save

      yield if block_given?

      begin
        Stripe::Charge.create({
          amount: (order.grand_total.to_s + "00").to_i,
          currency: 'idr',
          source: stripe_token,
          metadata: { name: current_user.name, order_id: order.id, user_id: current_user.id },
          receipt_email: ADMIN_EMAIL
        })

        AdminMailer.with(order: order).order_notification.deliver_now
        flash[:success] = 'Your order has been paid!'
      rescue Stripe::CardError => e
        body = e.json_body
        err  = body[:error]
        flash[:error] = err[:message]
      rescue Stripe::RateLimitError => e
        flash[:error] = e.message
      rescue Stripe::AuthenticationError => e
        flash[:error] = e.message
      rescue Stripe::APIConnectionError => e
        flash[:error] = e.message
      rescue Stripe::StripeError => e
        flash[:error] = e.message
      rescue Stripe::InvalidRequestError => e
        flash[:error] = e.message
      end

      if flash[:error].present?
        order.payment_fail!(flash[:error])
        redirect_to checkout_order_path(order) and return
      else
        order.payment_success!
        redirect_to order_path(order) and return
      end
    else
      render 'carts/checkout'  and return
    end
  end
end