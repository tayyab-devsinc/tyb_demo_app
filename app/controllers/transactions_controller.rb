class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = if current_user.admin?
                      Transaction.paginate(page: params[:page], per_page: 10)
                    else
                      current_user.transactions.paginate(page: params[:page], per_page: 10)
                    end
  end
end
