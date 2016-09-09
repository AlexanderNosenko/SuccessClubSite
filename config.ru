# This file is used by Rack-based servers to start the application.
# ADD SINATRA APP PATH TO YOUR ENVIRONMENT VARIABLE
# export LANDINGS_APP_PATH =  "/home/flaminisx/workspace/web/landings.improf.club" - example
# require ENV['LANDINGS_APP_PATH'] + '/frank.rb'
require ::File.expand_path('../config/environment', __FILE__)
map "/" do
  run Rails.application
end
# map '/landing' do
#   run LandingPages
# end
