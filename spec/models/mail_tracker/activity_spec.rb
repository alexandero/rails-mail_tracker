require 'spec_helper'

describe MailTracker::Activity do
  it 'should have many activities' do
    MailTracker::Activity.new.email.should be_nil
  end
end