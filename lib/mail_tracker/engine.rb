require 'mail_tracker'
require 'rails'
require 'action_controller'

module MailTracker
  class Engine < ::Rails::Engine

    config.mount_at = '/'

  end
end
