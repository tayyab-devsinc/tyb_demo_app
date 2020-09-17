require 'rake'
namespace :transaction do
  task daily_transaction: :environment do
    puts 'Starting daily transaction process'
    Subscription.all.where(billing_day: Date.today.day).each(&:charge_fee)
    puts 'Daily transaction process completed'
  end
end
