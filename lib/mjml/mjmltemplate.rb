module Mjml
  mattr_accessor :processing_options, :renderer
  @@processing_options = {}

  class Mjmltemplate
    def self.to_html(compiled_source)
      Mjml::Parser.new(compiled_source).render.html_safe
    end
  end
end
