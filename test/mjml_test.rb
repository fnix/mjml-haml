require "test_helper"

class Notifier < ActionMailer::Base
  self.view_paths = File.expand_path("../views", __FILE__)

  layout false

  def contact(recipient, format_type)
    @recipient = recipient
    mail(:to => @recipient, :from => "john.doe@example.com") do |format|
      format.send(format_type)
    end
  end

  def link(format_type)
    mail(:to => 'foo@bar.com', :from => "john.doe@example.com") do |format|
      format.send(format_type)
    end
  end

  def user(format_type)
    mail(:to => 'foo@bar.com', :from => "john.doe@example.com") do |format|
      format.send(format_type)
    end
  end

  def no_partial(format_type)
    mail(:to => 'foo@bar.com', :from => "john.doe@example.com") do |format|
      format.send(format_type)
    end
  end

  def multiple_format_contact(recipient)
    @recipient = recipient
    mail(:to => @recipient, :from => "john.doe@example.com", :template => "contact") do |format|
      format.text  { render 'contact' }
      format.html  { render 'contact' }
    end
  end
end

# class TestRenderer < ActionView::PartialRenderer
#   attr_accessor :show_text
#   def initialize(render_options = {})
#     @show_text = render_options.delete(:show_text)
#     super(render_options)
#   end

#   def normal_text(text)
#     show_text ? "TEST #{text}" : "TEST"
#   end
# end

class MjmlTest < ActiveSupport::TestCase

  setup do
    @original_renderer = Mjml.renderer
    @original_processing_options = Mjml.processing_options
  end

  teardown do
    Mjml.renderer = @original_renderer
    Mjml.processing_options = @original_processing_options
  end

  test "html should be sent as html" do
    email = Notifier.contact("you@example.com", :mjml)
    assert_equal "text/html", email.mime_type
    assert_no_match(/<mj-body>/, email.body.encoded.strip)
    assert_match(/<body/, email.body.encoded.strip)
    assert_match('<p>Hello from <a href="https://github.com/fnix/mjml-haml">haml-rails</a></p>', email.body.encoded.strip)
  end

  test 'with partial' do
    email = Notifier.user(:mjml)
    assert_equal "text/html", email.mime_type
    assert_match(/Hello Partial/, email.body.encoded.strip)
    assert_no_match(/mj-text/, email.body.encoded.strip)
  end

  test 'without a partial' do
    email = Notifier.no_partial(:mjml)
    assert_equal "text/html", email.mime_type
    assert_match(/Hello World/, email.body.encoded.strip)
    assert_no_match(/mj-text/, email.body.encoded.strip)
  end

  # test "plain text should be sent as a plain text" do
  #   email = Notifier.contact("you@example.com", :text)
  #   assert_equal "text/plain", email.mime_type
  #   assert_equal "<mj-body></mj-body>", email.body.encoded.strip
  # end

  # test 'dealing with multipart e-mails' do
  #   email = Notifier.multiple_format_contact("you@example.com")
  #   assert_equal 2, email.parts.size
  #   assert_equal "multipart/alternative", email.mime_type
  #   assert_equal "text/plain", email.parts[0].mime_type
  #   assert_equal "<mj-body></mj-body>",
  #     email.parts[0].body.encoded.strip
  #   assert_equal "text/html", email.parts[1].mime_type
  #   assert_not_equal "<mj-body></mj-body>",
  #     email.parts[1].body.encoded.strip
  # end

  # test "with a custom renderer" do
  #   Mjml.renderer = TestRenderer
  #   email = Notifier.contact("you@example.com", :html)
  #   assert_equal "text/html", email.mime_type
  #   assert_equal "<p>TEST<strong>TEST</strong>TEST</p>", email.body.encoded.strip
  # end

  # test "with a custom renderer and options" do
  #   Mjml.renderer = TestRenderer.new(:show_text => true)
  #   email = Notifier.contact("you@example.com", :html)
  #   assert_equal "text/html", email.mime_type
  #   assert_equal "<p>TEST Dual templates <strong>TEST rocks</strong>TEST !</p>", email.body.encoded.strip
  # end

  # test 'with custom mjml processing options' do
  #   Mjml.processing_options = {:autolink => true}
  #   email = Notifier.link(:html)
  #   assert_equal "text/html", email.mime_type
  #   assert_equal '<p>Hello from <a href="http://www.sighmon.com">http://www.sighmon.com</a></p>', email.body.encoded.strip
  # end

end
