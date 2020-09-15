class InvoiceMailer < ApplicationMailer
  default from: 'muhammadt.tayyab@devsinc.com'

  def invoice_email(current_user_id, transaction_id)
    @user = User.find_by_id(current_user_id)
    @transaction = Transaction.find_by_id(transaction_id)
    @url = 'http://tyb_demo_app.herokuapp.com'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
