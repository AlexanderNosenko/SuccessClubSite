namespace :db do
  desc "TODO"
  task rearrange: :environment do
    if Rails.env == "development" then
      ENV['VERSION']= '0'
    	Rake::Task['db:migrate'].invoke
    	Rake::Task['db:migrate'].reenable
    	ENV.delete 'VERSION'
    	Rake::Task["db:migrate"].invoke
    	Rake::Task['db:seed'].execute()
      puts "done!\n"
    else
      puts "NOT PERMITED IN PRODUCTION MODE"
    end
  end

  desc "Adding needed partnership_depth values"
  task create_part_depth: :environment do
    percents = [20, 10, 5, 3, 2, 1, 1, 1, 1, 1]

    ActiveRecord::Base.connection.execute("TRUNCATE partnership_depths")
    # PartnershipDepth.delete_all
    # ActiveRecord::Base.connection.reset_sequence!('partnership_depths', 'id')
    percents.each do |percent|
      depth = PartnershipDepth.create!(percent: percent)
    end
  end

  desc "Adding wallets for already created users"
  task create_wallets: :environment do
    User.all.each do |user|
      if user.wallet.nil?
        Wallet.create(user: user, main_balance: 0, bonus_balance: 0)
      end
    end
  end

  # desc "Adding bonuses for first 500"
  # task add_bonuses: :environment do
  # # It may work in absolutely different way, have to save average value
  # # And track, which users we have already payed
  #   average = 500
  #   per_person = 200

  #   User.all.each do |user|
  #     user.wallet.bonus_balance += per_person
  #     average -= 1
  #   end
  # end

  desc "Fixing Roles table"
  task fix_roles: :environment do
    roles = Role.all

    roles_data = {
      "user" => {
        description: "Новичок",
        switch_price: 0,
        month_price: 0,
        spam_per_week: 0,
        adv_per_month: 0,
        online_event_per_week: 0,
        landing_pages_number: 0,
        month_team_bonus_ppm: 0,

        partnership_depth: 1,

        can_edit_video: false,
        can_start_auction: false,
        know_partners_backref: false,
        have_investment_belay: false
      }, 
      "partner" => {
        description: "Партнер",
        switch_price: 5,
        month_price: 5,
        spam_per_week: 0,
        adv_per_month: 0,
        online_event_per_week: 0,
        landing_pages_number: 1,
        month_team_bonus_ppm: 5,

        partnership_depth: 2,

        can_edit_video: false,
        can_start_auction: false,
        know_partners_backref: true,
        have_investment_belay: false
      }, 
      "vip" => {
        description: "VIP Партнер",
        switch_price: 15,
        month_price: 30,
        spam_per_week: 1,
        adv_per_month: 1,
        online_event_per_week: 1,
        landing_pages_number: 3,
        month_team_bonus_ppm: 50,

        partnership_depth: 5,

        can_edit_video: true,
        can_start_auction: true,
        know_partners_backref: true,
        have_investment_belay: false

      }, 
      "leader" => {
        description: "Лидер",
        switch_price: 30,
        month_price: 50,
        spam_per_week: 10,
        adv_per_month: 5,
        online_event_per_week: 3,
        landing_pages_number: 8,
        month_team_bonus_ppm: 70 ,

        partnership_depth: 10,

        can_edit_video: true,
        can_start_auction: true,
        know_partners_backref: true,
        have_investment_belay: true
      } 
    }
    roles.each do |role|
      name = role.name
      if not roles_data.keys.size
        role.destroy!
      elsif (roles_data.keys.include? name)
        role.update_attributes!(**roles_data[name])
        roles_data.delete(name)
      else
        name = roles_data.keys.first
        role.update_attributes!(name: name, **roles_data[name])
        roles_data.delete(name)
      end
    end

    User.all.each do |user|
      user.update_attributes!(role: Role.find_by(name: 'user'))
    end
  end
end
# Role.create name: "leader", description: "Лидер"
# Role.create name: "user", description: "Новичок"
# Role.create name: "vip", description: "VIP Партнер"
# Role.create name: "partner", description: "Партнер"