require File.expand_path('../engine', __FILE__)

module MailTracker
  module UrlHelper

    raise ArgumentError, 'Setup config.action_mailer.default_url_options' unless MailTracker::Engine.config.action_mailer.default_url_options

    URL_HELPERS = Rails.application.routes.url_helpers
    URL_HOST = MailTracker::Engine.config.action_mailer.default_url_options[:host]

    # TODO: implement via method_missing
    def tracking_url(kind, url = nil)
      options = {
          :host => URL_HOST,
          :kind => kind,
          :email_id => email.id
      }
      options[:origin_url] = ERB::Util::url_encode(url) if url
      URL_HELPERS.mail_tracking_url(options)
    end
  end
end