module Mjml
  mattr_accessor :processing_options, :renderer
  @@processing_options = {}

  class MjmlTemplate
    def self.to_html(compiled_source)
      if defined?(Redcarpet)
        Mjml.renderer ||= Redcarpet::Render::HTML
        Redcarpet::MjmlTemplate.new(Mjml.renderer, Mjml.processing_options).render(compiled_source)
      elsif defined?(Kramdown)
        Kramdown::Document.new(compiled_source, Mjml.processing_options).to_html
      else
        raise StandardError, "MjmlTemplate processor unavailable, please add either Redcarpet or Kramdown to your project"
      end
    end
  end
end
