namespace :db do
  desc "TODO"
  task rearrange: :environment do
  	ENV['VERSION']= '0'
	Rake::Task['db:migrate'].invoke
	Rake::Task['db:migrate'].reenable
	ENV.delete 'VERSION'
	Rake::Task["db:migrate"].invoke
  	Rake::Task['db:seed'].execute()
  end

end
