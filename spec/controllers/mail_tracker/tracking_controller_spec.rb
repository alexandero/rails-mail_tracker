require 'spec_helper'

describe MailTracker::TrackingController do

  it 'should create activity for links and images from email' do
    email = TestNotification.hello
    email.deliver

    doc = Nokogiri::HTML(extract_html(email))
    link_url = doc.at_css('a')[:href]
    image_src = doc.at_css('img:last')[:src]


    link_url_hash = Rails.application.routes.recognize_path(link_url, :method => :get)

    get :create, link_url_hash

    mt_email = MailTracker::Email.where(:message_id => email.message_id).first
    mt_email.should be_present
    mt_email.activities.count == 1
    mt_activity = mt_email.activities.last
    mt_activity.qty.should == 1
    mt_activity.kind.should == MailTracker::Kind::CLICK
    response.should redirect_to mt_activity.origin_url


    # once again
    get :create, link_url_hash

    mt_email.reload
    mt_email.activities.count == 1
    mt_activity = mt_email.activities.last
    mt_activity.qty.should == 2
    mt_activity.kind.should == MailTracker::Kind::CLICK
    response.should redirect_to mt_activity.origin_url


    image_src_hash = Rails.application.routes.recognize_path(image_src, :method => :get)

    get :create, image_src_hash

    mt_email.reload
    mt_email.activities.count == 2
    mt_activity = mt_email.activities.last
    mt_activity.qty.should == 1
    mt_activity.kind.should == MailTracker::Kind::OPEN
    response.body.should be_blank
  end

  private

    def extract_html(message)
      parts = (message.multipart?) ? message.parts : [message]
      html_parts = parts.select { |part| /text\/html/ === part.content_type }
      html_parts.first.body.decoded
    end
end