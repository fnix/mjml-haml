require "test_helper"

class MjmlTest < ActiveSupport::TestCase
  setup do
    @original_redcarpet = Redcarpet
    @original_kramdown = Kramdown
  end

  teardown do
    Object.const_set(:Redcarpet, @original_redcarpet) unless defined?(Redcarpet)
    Object.const_set(:Kramdown, @original_kramdown) unless defined?(Kramdown)
  end

  test 'with Redcarpet template processor' do
    Object.send(:remove_const, :Kramdown)
    assert_equal "<p>Dual templates <strong>rocks</strong>!</p>", Mjml::Mjmltemplate.to_html("Dual templates **rocks**!").strip
  end

  test 'with Kramdown template processor' do
    Object.send(:remove_const, :Redcarpet)
    assert_equal "<p>Dual templates <strong>rocks</strong>!</p>", Mjml::Mjmltemplate.to_html("Dual templates **rocks**!").strip
  end

  test 'when there is no known template processor available' do
    Object.send(:remove_const, :Redcarpet)
    Object.send(:remove_const, :Kramdown)

    assert_raise(StandardError) { Mjml::Mjmltemplate.to_html("Dual templates **rocks**!") }
  end
end
