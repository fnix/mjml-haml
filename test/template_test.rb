require "test_helper"

class MjmlTest < ActiveSupport::TestCase
  
  test 'with Mjmltemplate processor' do
    assert_not_equal "<mj-body></mj-body>", Mjml::Mjmltemplate.to_html("<mjml><mj-body><mj-container><mj-section><mj-column></mj-column></mj-section></mj-container></mj-body></mjml>").strip
  end

end
