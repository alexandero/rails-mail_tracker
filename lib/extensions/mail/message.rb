require File.expand_path('../../../mail_tracker/injector', __FILE__)
require 'mail'

module Mail
  class Message

    alias_method :original_deliver, :deliver
    alias_method :original_deliver!, :deliver!

    def deliver
      inject_tracking_code
      original_deliver
    end

    def deliver!
      inject_tracking_code
      original_deliver!
    end

    private

      def inject_tracking_code
        ready_to_send!
        MailTracker::Injector.process self
      end

  end
end