class SessionsController < ApplicationController
  before_action :set_cart, except: :destroy
  before_action :set_user_by_pass_token, only: [:reset_password, :update_password]

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      @cart.update(user_id: user.id)
      path = params[:redirect_to] || root_path
      redirect_to path, notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

  def forgot
  end

  def reset_password
  end

  def update_password
    @user.password_confirmation_token = nil

    if @user.update(update_password_params)
      redirect_to new_session_path, notice: 'Password successfuly changed!, Please Login'
    else
      render :reset_password
    end
  end

  private
    def update_password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def set_user_by_pass_token
      @user = User.find_by_password_confirmation_token(params[:id])
      raise ActiveRecord::RecordNotFound if @user.blank?
    end
end
