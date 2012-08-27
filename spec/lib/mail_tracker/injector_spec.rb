require 'spec_helper'

describe MailTracker::Injector do

  before :each do
    @message = TestNotification.hello
    @message.deliver!
    @injector = MailTracker::Injector.process @message
  end

  it 'should be properly initialized' do
    @injector.message.should == @message
    @injector.email.should be_present
    @injector.email.message_id.should == @message.message_id
  end

  it 'should be properly inject_code!' do
    message = TestNotification.hello
    part = message.parts.first
    original_part = part.dup
    MailTracker::Injector.new(message, []).send :inject_code!, part
    doc = Nokogiri::HTML(part.body.decoded)
    doc_original = Nokogiri::HTML(original_part.body.decoded)

    link = doc.css('a:first').first['href'].split('/')
    link.should include 'tracking'
    link.should include ::MailTracker::Kind::CLICK.to_s
    link.should include ERB::Util::url_encode(doc_original.css('a:first').first['href'])

    link = doc.css('img:last').first['src'].split('/')
    link.should include 'tracking'
    link.should include ::MailTracker::Kind::OPEN.to_s
  end

end