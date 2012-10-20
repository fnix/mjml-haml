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

  def multiple_format_contact(recipient)
    @recipient = recipient
    mail(:to => @recipient, :from => "john.doe@example.com", :template => "contact") do |format|
      format.text  { render 'contact' }
      format.html  { render 'contact' }
    end
  end
end

class TestRenderer < Redcarpet::Render::HTML
  attr_accessor :show_text
  def initialize(render_options = {})
    @show_text = render_options.delete(:show_text)
    super(render_options)
  end

  def normal_text(text)
    show_text ? "TEST #{text}" : "TEST"
  end
end

class MarkerbTest < ActiveSupport::TestCase

  setup do
    @original_renderer = Markerb.renderer
    @original_processing_options = Markerb.processing_options
  end

  teardown do
    Markerb.renderer = @original_renderer
    Markerb.processing_options = @original_processing_options
  end

  test "plain text should be sent as a plain text" do
    email = Notifier.contact("you@example.com", :text)
    assert_equal "text/plain", email.mime_type
    assert_equal "Dual templates **rocks**!", email.body.encoded.strip
  end

  test "html should be sent as html" do
    email = Notifier.contact("you@example.com", :html)
    assert_equal "text/html", email.mime_type
    assert_equal "<p>Dual templates <strong>rocks</strong>!</p>", email.body.encoded.strip
  end

  test 'dealing with multipart e-mails' do
    email = Notifier.multiple_format_contact("you@example.com")
    assert_equal 2, email.parts.size
    assert_equal "multipart/alternative", email.mime_type
    assert_equal "text/plain", email.parts[0].mime_type
    assert_equal "Dual templates **rocks**!",
      email.parts[0].body.encoded.strip
    assert_equal "text/html", email.parts[1].mime_type
    assert_equal "<p>Dual templates <strong>rocks</strong>!</p>",
      email.parts[1].body.encoded.strip
  end

  test "with a custom renderer" do
    Markerb.renderer = TestRenderer
    email = Notifier.contact("you@example.com", :html)
    assert_equal "text/html", email.mime_type
    assert_equal "<p>TEST<strong>TEST</strong>TEST</p>", email.body.encoded.strip
  end

  test "with a custom renderer and options" do
    Markerb.renderer = TestRenderer.new(:show_text => true)
    email = Notifier.contact("you@example.com", :html)
    assert_equal "text/html", email.mime_type
    assert_equal "<p>TEST Dual templates <strong>TEST rocks</strong>TEST !</p>", email.body.encoded.strip
  end

  test 'with custom markdown processing options' do
    Markerb.processing_options = {:autolink => true}
    email = Notifier.link(:html)
    assert_equal "text/html", email.mime_type
    assert_equal '<p>Hello from <a href="http://www.fcstpauli.com">http://www.fcstpauli.com</a></p>', email.body.encoded.strip
  end

  test 'with partial' do
    email = Notifier.user(:html)
    assert_equal "text/html", email.mime_type
    assert_equal '<p>woot! <strong>Partial</strong></p>', email.body.encoded.strip
  end
end
