class UserMailer < ApplicationMailer
  def confirmation
    @user = params[:user]
    mail(to: @user.email, subject: 'Azzuri Store - Email Confirmation')
  end

  def reset_password
    @user = params[:user]
    mail(to: @user.email, subject: 'Azzuri Store - Reset Password')
  end
end