class Transaction < ApplicationRecord
  belongs_to :subscription
  belongs_to :user

  after_save :send_transaction

  private

  def send_transaction
    InvoiceMailer.with(current_user_id: user_id, transaction_id: id).invoice_email(user_id, id).deliver_later
  end
end
