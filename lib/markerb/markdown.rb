module Markerb
  mattr_accessor :processing_options, :renderer
  @@processing_options = {}

  class Markdown
    def self.to_html(compiled_source)
      if defined?(Redcarpet)
        Markerb.renderer ||= Redcarpet::Render::HTML
        Redcarpet::Markdown.new(Markerb.renderer, Markerb.processing_options).render(compiled_source)
      elsif defined?(Kramdown)
        Kramdown::Document.new(compiled_source, Markerb.processing_options).to_html
      else
        raise StandardError, "Markdown processor unavailable, please add either Redcarpet or Kramdown to your project"
      end
    end
  end
end
