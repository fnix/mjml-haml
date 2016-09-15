require "test_helper"

class Notifier < ActionMailer::Base
  self.view_paths = File.expand_path("../views", __FILE__)

  layout false

  def contact(recipient)
    @recipient = recipient
    mail(:to => @recipient, :from => "john.doe@example.com")
  end

  def link
    mail(:to => 'foo@bar.com', :from => "john.doe@example.com")
  end

  def user
    mail(:to => 'foo@bar.com', :from => "john.doe@example.com")
  end

  def no_partial
    mail(:to => 'foo@bar.com', :from => "john.doe@example.com")
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
    email = Notifier.contact("you@example.com")
    assert_equal "text/html", email.mime_type
    assert_no_match(/<mj-body>/, email.body.encoded.strip)
    assert_match(/<body/, email.body.encoded.strip)
    assert_match('<p>Hello from <a href="https://github.com/fnix/mjml-haml">haml-rails</a></p>', email.body.encoded.strip)
  end

  test 'with partial' do
    email = Notifier.user
    assert_equal "text/html", email.mime_type
    assert_match(/Hello Partial/, email.body.encoded.strip)
    assert_no_match(/mj-text/, email.body.encoded.strip)
  end

  test 'without a partial' do
    email = Notifier.no_partial
    assert_equal "text/html", email.mime_type
    assert_match(/Hello World/, email.body.encoded.strip)
    assert_no_match(/mj-text/, email.body.encoded.strip)
  end
end
