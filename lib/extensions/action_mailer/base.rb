require File.expand_path('../../../mail_tracker/injector', __FILE__)

module ActionMailer
  class Base < AbstractController::Base

    alias_method :original_initialize, :initialize

    def initialize(method_name=nil, *args)
      message = original_initialize method_name, *args
      MailTracker::Injector.process message
      message
    end

  end
end