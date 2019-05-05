class ConfirmationsController < ApplicationController
  def new
  end

  def create
  end

  def confirm
    user = User.find_by(confirmation_token: params[:id])

    if user && user.update!(confirmed_at: DateTime.now)
      session[:user_id] = user.id
      path = cookies[:redirect_to] || root_path
      cookies.delete :redirect_to
      redirect_to path, flash: { notice: 'You\'re Logged In!', success: 'Your Account has been confirmed!' }
    else
      redirect_to root_path, flash: { error: 'Token Not Found!' }
    end
  end

  def send_password
    user = User.find_by(email: params[:email])

    if user && !user.is_admin?
      user.reset_password!

      redirect_to root_path, flash: { notice: 'Please check your email password confirmation' }
    else
      redirect_to forgot_sessions_path, flash: { error: 'Email not found!' }
    end
  end
end