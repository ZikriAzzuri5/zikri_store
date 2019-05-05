class RegistrationsController < ApplicationController
  before_action :set_cart

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.with(user: @user).confirmation.deliver_now
      redirect_to new_session_path, notice: 'Please Check Your Email For Confirmation'
    else
      render :new
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
