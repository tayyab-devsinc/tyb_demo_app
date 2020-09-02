class InvoiceMailer < ApplicationMailer
  default from: 'tyb_demo_app@example.com'

  def invoice_email(current_user, transaction)
    @user = current_user
    @transaction = transaction
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
