# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'mjml/version'

Gem::Specification.new do |s|
  s.name        = 'mjml-rails'
  s.version     = Mjml::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.summary     = 'MJML + ERb templates'
  s.email       = 'sighmon@sighmon.com'
  s.homepage    = 'https://github.com/sighmon/mjml-rails'
  s.description = 'Render MJML + ERb template views in Rails'
  s.authors     = ['Simon Loffler']
  s.license     = 'MIT'

  s.files         = Dir['MIT-LICENSE', 'README.md', 'lib/**/*']
  s.test_files    = Dir['test/**/*.rb']
  s.require_paths = ['lib']

end
