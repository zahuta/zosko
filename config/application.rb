require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(*Rails.groups)

module Gamified
  class Application < Rails::Application

    # Přidání složky s fonty do seznamu míst, které se načítají při spuštění
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

    # Nastavení lokální časové zóny
    config.time_zone = 'Prague'
  end
end
