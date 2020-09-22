class OrderMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def confirmation_email(order)
    @order = order
    mail(to: @order.email, subject: "Confirmation of Order ##{@order.id}")
  end
end
