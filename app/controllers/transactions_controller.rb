class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = policy_scope(Transaction).paginate(page: params[:page], per_page: 10)
  end
end
