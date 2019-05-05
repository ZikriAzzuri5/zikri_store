class AdminMailer < ApplicationMailer
  add_template_helper(ApplicationHelper)

  def order_notification
    @order = params[:order]
    mail(to: ADMIN_EMAIL, subject: "Azzuri Store - Order ##{@order.id}")
  end
end