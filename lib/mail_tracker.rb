module MailTracker
  require 'mail_tracker/engine'

  def self.table_name_prefix
    'mail_tracker_'
  end
end

#require 'extensions/action_mailer/base'
require 'extensions/mail/message'
