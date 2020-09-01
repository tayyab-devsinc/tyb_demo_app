class TransactionsController < ApplicationController
  def index
    @transactions = if current_user.admin?
                      Transaction.paginate(page: params[:page], per_page: 10)
                    else
                      current_user.transactions.paginate(page: params[:page], per_page: 10)
                    end
  end

  def create(subscription)
    transaction = Transaction.new(subscription_id: subscription.id,
                                  user_id: subscription.user_id,
                                  amount: subscription.plan.monthly_fee)
    if transaction.save
      flash[:success] = 'Subscribed Successfully'
      redirect_to subscriptions_url
    else
      flash[:danger] = 'Error occurred, Try Again'
      render subscriptions_url
    end
  end
end
