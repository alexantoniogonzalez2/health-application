require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AplicacionMedica
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    I18n.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = :en
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif )

    #Zona de tiempo  
    config.time_zone = 'Melbourne' 
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false 
    #Nombre del sitio
    config.site_name = "MedRacer"

    #config.middleware.use WickedPdf::Middleware 




  end
end
