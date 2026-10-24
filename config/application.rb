require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module ArchiviewRl
  class Application < Rails::Application
    config.load_defaults 8.1
    config.autoload_lib(ignore: %w[assets tasks])
    config.generators.system_tests = nil
    config.time_zone = "Rome"
    config.i18n.load_path += Dir[Rails.root.join("config/locales/**/*.yml")]
    config.i18n.available_locales = %i[it en]
    config.i18n.default_locale = :it
    config.session_store :disabled
  end
end
