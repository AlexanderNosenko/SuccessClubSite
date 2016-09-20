# This file is used by Rack-based servers to start the application.
# ADD SINATRA APP PATH TO YOUR ENVIRONMENT VARIABLE
# example:
# export LANDINGS_APP_PATH="/path/to/landings.improf.club"
# require File.join(ENV['LANDINGS_APP_PATH'], 'app.rb')
require ::File.expand_path('../config/environment', __FILE__)
map "/" do
  run Rails.application
end
# map '/landing' do
#   run LandingPages
# end
