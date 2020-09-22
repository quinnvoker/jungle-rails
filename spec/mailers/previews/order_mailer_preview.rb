# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def confirmation_email
    OrderMailer.confirmation_email(Order.last)
  end
end
