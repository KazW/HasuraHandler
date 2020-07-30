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
  spec.summary     = 'Integrates Hasura with Rails'
  spec.description = 'HasuraHandler is a Rails framework that makes building microservices for Hasura easy.'
  spec.license     = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails', '~> 6.0.3', '>= 6.0.3.2'
end
