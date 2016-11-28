namespace :user do
  desc "check users status"
  task role_check: :environment do
    User.all.each do |user|
      if user.reactivate_at && user.expired?
        price = user.role.month_price
        if user.enough? price
          user.take_money price
          user.activated_at = Time.now
          user.reactivated_at = Time.now + 30.days
        else
          user.drop_role
          user.activated_at = nil
          user.reactivated_at = nil
        end
      end
    end
  end
end
