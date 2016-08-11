require "rails/generators/erb/mailer/mailer_generator"
require "generators/haml/mailer/mailer_generator" if Mjml::TEMPLATE_ENGINE == :haml

module Mjml
  module Generators
    if Mjml::TEMPLATE_ENGINE == :haml
      PARENT_GENERATOR = Haml::Generators::MailerGenerator
      TEMPLATES_FOLDER = '../templates_haml'
    else
      PARENT_GENERATOR = Erb::Generators::MailerGenerator
      TEMPLATES_FOLDER = '../templates'
    end

    class MailerGenerator < Mjml::Generators::PARENT_GENERATOR
      source_root File.expand_path(Mjml::Generators::TEMPLATES_FOLDER, __FILE__)

      protected

      def format
        nil # Our templates have no format
      end

      def formats
        [format]
      end

      def handler
        :mjml
      end
    end
  end
end
