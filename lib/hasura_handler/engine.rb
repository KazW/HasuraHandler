module HasuraHandler
  class Engine < ::Rails::Engine
    isolate_namespace HasuraHandler
    config.generators.api_only = true

    if Rails.version.to_f < 6
      config.eager_load_paths += Dir[Rails.root.join('app', '{actions,reactions}', '*.rb')]
    end

    config.to_prepare do
      Dir[Rails.root.join('app', '{actions,reactions}', '*.rb')].each{ |file| require_dependency file }
    end
  end
end
