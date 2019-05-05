class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def authenticate_admin!
    if current_user.blank?
      redirect_to new_session_path, notice: 'Please login to continue'
    elsif current_user.present? && !current_user.is_admin?
      redirect_to root_path, notice: 'Your account is unauthorized'
    end
  end

  def authenticate_user!
    if current_user.blank?
      redirect_to new_session_path(redirect_to: request.url), notice: 'Please login to continue'
    end
  end

  def authenticate_only_user!
    if current_user.present? && current_user.is_admin?
      redirect_to root_path, notice: 'Please login as user to continue'
    end
  end

  protected
    def set_cart
      return if current_user && current_user.is_admin?
      uuid = cookies[:cart_uuid]

      if current_user
        @cart = Cart.find_by(user_id: current_user.id)
      elsif uuid
        @cart = Cart.find_by(uuid: uuid)
      end

      @cart ||= Cart.create(user_id: session[:user_id])

      cookies[:cart_uuid] = @cart.uuid
    end
end