require "redcarpet"

module Markerb
  mattr_accessor :processing_options, :renderer
  @@processing_options = {}
  @@renderer = Redcarpet::Render::HTML

  class Markdown
    def self.to_html(compiled_source)
      Redcarpet::Markdown.new(Markerb.renderer, Markerb.processing_options).render(compiled_source)
    end
  end
end
