require "test_helper"

class MjmlTest < ActiveSupport::TestCase
  
  test 'with Mjmltemplate processor' do
    assert_not_equal "<mj-body></mj-body>", Mjml::Mjmltemplate.to_html("<mj-body></mj-body>").strip
  end

end
