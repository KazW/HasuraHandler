module HasuraHandler
  class Engine < ::Rails::Engine
    isolate_namespace HasuraHandler
    config.generators.api_only = true
  end
end
