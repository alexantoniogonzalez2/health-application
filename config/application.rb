require File.expand_path('../boot', __FILE__)

require 'rails/all'
#require 'wicked_pdf'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module AplicacionMedica
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    I18n.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = :es
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif )

    #Zona de tiempo  
    config.time_zone = 'Santiago' 
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false 
    #Nombre del sitio
    config.site_name = "MedRace"

    #config.middleware.use WickedPdf::Middleware 

  end
end

