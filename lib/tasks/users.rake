namespace :user do
  desc "check users status"
  task role_check: :environment do
    puts "Users count: #{ User.count }"
    paid, dropped = 0, 0
    User.all.each do |user|
      if user.reactivate_at && user.expired?
        price = user.role.month_price
        if user.enough? price
          user.take_money price
          user.activated_at = Time.now
          user.reactivate_at = Time.now + 30.days
          user.save
          paid += 1
        else
          Notifications.role_reset(user).deliver_now
          user.drop_role
          user.activated_at = nil
          user.reactivate_at = nil
          user.save
          dropped += 1
        end
      end
    end
    puts "Users paid for status: #{paid}, dropped roles: #{dropped}"
  end
end
