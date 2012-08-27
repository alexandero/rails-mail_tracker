ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup'

require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'

Bundler.require(:default)

module MailTracker
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.cache_classes = true
    config.whiny_nils = true
    config.consider_all_requests_local       = true
    config.action_controller.perform_caching = false
    config.action_dispatch.show_exceptions = false
    config.action_controller.allow_forgery_protection    = false
    config.action_mailer.delivery_method = :test
    config.active_support.deprecation = :stderr
    config.action_mailer.default_url_options = { :host => "foo.com" }
    config.paths.config.database = "spec/database.yml"
  end
end


require Rails.root.join('lib/mail_tracker')


MailTracker::Application.initialize!


require 'rspec/rails'
Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}
RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
end

