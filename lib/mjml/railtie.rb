module Mjml
  class Railtie < Rails::Railtie
    config.mjml = Mjml
    config.app_generators.mailer :template_engine => :mjml

    initializer "mjml-haml.register_template_handler" do
      ActionView::Template.register_template_handler :mjml, Mjml::Handler.new
    end
  end
end
