class UsagesController < ApplicationController
  def index
    @subscriptions = Subscription.paginate(page: params[:page], per_page: 10)
  end

  def add(subscription)

  end

end
