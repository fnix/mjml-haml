require "action_view"
require "action_view/template"
require "mjml/mjmltemplate"
require "mjml/railtie"

module Mjml
  class Handler
    def erb_handler
      @erb_handler ||= ActionView::Template.registered_template_handler(:erb)
    end

    def call(template)
      compiled_source = erb_handler.call(template)
      if template.formats.include?(:html)
        "Mjml::Mjmltemplate.to_html(begin;#{compiled_source};end).html_safe"
      else
        compiled_source
      end
    end
  end
end

ActionView::Template.register_template_handler :mjml, Mjml::Handler.new
