$:.push File.expand_path('lib', __dir__)

Gem::Specification.new do |spec|
  spec.name        = 'hasura_handler'
  spec.version     = '0.1.7'
  spec.authors     = ['Kaz Walker']
  spec.email       = ['me@kaz.codes']
  spec.homepage    = 'https://kazw.github.io/HasuraHandler'
  spec.summary     = 'Integrates Hasura with Rails'
  spec.description = 'HasuraHandler is a Rails framework that makes building microservices for Hasura easy.'
  spec.license     = 'MIT'

  spec.metadata = {
    'bug_tracker_uri'   => 'https://github.com/KazW/HasuraHandler/issues',
    'documentation_uri' => 'https://kazw.github.io/HasuraHandler',
    'homepage_uri'      => 'https://kazw.github.io/HasuraHandler',
    'source_code_uri'   => 'https://github.com/KazW/HasuraHandler'
  }

  spec.files = Dir[
    '{app,config,lib}/**/*',
    'MIT-LICENSE',
    'Rakefile',
    'README.md'
  ]

  spec.add_dependency 'rails', '>= 5.0'
end
