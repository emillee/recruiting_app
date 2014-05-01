require File.expand_path('../boot', __FILE__)

require 'rails/all'

require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Nytech
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :default_locale
    
    config.assets.paths << Rails.root.join('app', 'assets', 'components', 'fonts', 'templates', 'vendor')
    
    # Loads joins model folder
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**/}')]
    
    config.assets.precompile += [Rails.root.to_s + '/vendor/assets/javascripts/*.js']
    
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.svg *.woff *.eot *.ttf)
    
    config.active_record.schema_format = :ruby
  end
end
