require 'spec_helper'

describe MailTracker::Email do
  it 'should have many activities' do
    MailTracker::Email.new.activities.should be_empty
  end
end