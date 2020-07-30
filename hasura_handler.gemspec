$:.push File.expand_path('lib', __dir__)

Gem::Specification.new do |spec|
  spec.name        = 'hasura_handler'
  spec.version     = '0.1.4'
  spec.authors     = ['Kaz Walker']
  spec.email       = ['me@kaz.codes']
  spec.homepage    = 'https://kazw.github.io/HasuraHandler'
  spec.summary     = 'Integrates Hasura with Rails'
  spec.description = 'HasuraHandler is a Rails framework that makes building microservices for Hasura easy.'
  spec.license     = 'MIT'

  s.metadata = {
    'bug_tracker_uri'   => 'https://github.com/KazW/HasuraHandler/issues',
    'documentation_uri' => 'https://kazw.github.io/HasuraHandler',
    'homepage_uri'      => 'https://kazw.github.io/HasuraHandler',
    'source_code_uri'   => 'https://github.com/KazW/HasuraHandler'
  }

  spec.files = Dir[
    '{app,config,db,lib}/**/*',
    'MIT-LICENSE',
    'Rakefile',
    'README.md'
  ]

  spec.add_dependency 'rails', '~> 6.0.3', '>= 6.0.3.2'
end
