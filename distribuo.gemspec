$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'distribuo/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'distribuo'
  spec.version     = Distribuo::VERSION
  spec.authors     = ['Tom de Grunt']
  spec.email       = ['tom@degrunt.nl']
  spec.homepage    = 'https://code.entropydecelerator.com/components/distribuo'
  spec.summary     = 'Simple mobile app distribution'
  spec.description = 'Simple mobile app distribution'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'acts_as_list'
  spec.add_dependency 'app_parser'
  spec.add_dependency 'image_processing'
  spec.add_dependency 'pg'
  spec.add_dependency 'pundit'
  spec.add_dependency 'rails', '>= 6'

  spec.add_development_dependency 'auxilium', '~> 3'
end
