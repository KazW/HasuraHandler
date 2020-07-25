$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'hasura_handler/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'hasura_handler'
  spec.version     = HasuraHandler::VERSION
  spec.authors     = ['Kaz Walker']
  spec.email       = ['me@kaz.codes']
  spec.homepage    = 'https://github.com/KazW/HasuraHandler'
  spec.summary     = 'Provides an easy way to integrate with Hasura.'
  spec.description = 'Provides an easy way to integrate with Hasura.'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails', '~> 6.0.3', '>= 6.0.3.2'
  spec.add_dependency 'graphql-client', '~> 0.16.0'
  spec.add_development_dependency 'pry-rails', '~> 0.3.9'
end
