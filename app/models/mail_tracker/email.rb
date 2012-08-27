module MailTracker
  class Email < ::ActiveRecord::Base
    has_many :activities, :class_name => "MailTracker::Activity"
  end
end