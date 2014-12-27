require "rubygems"
require "bundler"
Bundler.setup

require "minitest/autorun"
require "active_support/test_case"

require "action_mailer"
require "rails/railtie"
require "rails/generators"
require "rails/generators/test_case"
require "redcarpet"
require "kramdown"

$:.unshift File.expand_path("../../lib", __FILE__)
require "markerb"

ActiveSupport::TestCase.test_order = :sorted if ActiveSupport::TestCase.respond_to? :test_order=

# Avoid annoying warning from I18n.
I18n.enforce_available_locales = false

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
