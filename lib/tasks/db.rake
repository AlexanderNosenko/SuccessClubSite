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

end
