# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'mjml/version'

Gem::Specification.new do |s|
  s.name        = 'mjml-haml'
  s.version     = Mjml::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.summary     = 'MJML + Haml templates'
  s.email       = 'kadu@fnix.com.br'
  s.homepage    = 'https://github.com/fnix/mjml-haml'
  s.description = 'Render MJML + Haml template views in Rails'
  s.authors     = ['Kadu Diógenes']
  s.license     = 'MIT'

  s.files         = Dir['MIT-LICENSE', 'README.md', 'lib/**/*']
  s.test_files    = Dir['test/**/*.rb']
  s.require_paths = ['lib']
  s.post_install_message = "Don't forget to install MJML e.g. \n$ npm install -g mjml"

  s.add_dependency 'haml-rails'
end
