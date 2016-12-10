namespace :user do
  desc "check users status"
  task role_check: :environment do
    puts "Users count: #{ User.count }"
    paid, dropped, expiring = 0, 0, 0
    developers_ids = [2, 85, 1136, 61, 56, 108, 118, 22, 1053] #[2, 56, 61, 85, 1136]
    User.where.not(id: developers_ids).each do |user|
      next until user.reactivate_at
      if user.expired?
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
      elsif user.expiring?
        Notifications.role_expiring(user).deliver_now
        expiring += 1
      end
    end
    puts "Users paid for status: #{paid}, dropped roles: #{dropped}, expiring: #{expiring}"
  end
end
