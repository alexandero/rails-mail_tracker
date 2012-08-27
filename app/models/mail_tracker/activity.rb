module MailTracker
  class Activity < ::ActiveRecord::Base
    belongs_to :email, :class_name => "MailTracker::Email"
  end
end