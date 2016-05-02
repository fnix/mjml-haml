module Mjml
  class Railtie < ::Rails::Railtie
    config.mjml = Mjml
    config.app_generators.mailer :template_engine => :mjml
  end
end