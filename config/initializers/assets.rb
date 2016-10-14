# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
%w( instruments/* business admin/instruments/* users/registrations admin/home admin/admin admin/users admin/payments admin/bonuses admin/instruments ).each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.js", "#{controller}.css"]
end

#Rails.application.config.assets.precompile += ['*.js', '*.css']
Rails.application.config.assets.precompile += %w( defaults.js empty.css)
Rails.application.config.assets.precompile += %w( instruments/landings.css )
Rails.application.config.assets.precompile << /\.(?:svg|eot|otf|woff|ttf)\z/