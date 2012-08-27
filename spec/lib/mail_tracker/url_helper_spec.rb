require 'spec_helper'

describe MailTracker::UrlHelper do

  class DummyClass
    include MailTracker::UrlHelper

    attr_reader :email
    def initialize
      @email = Object.new
      @email.instance_eval do
        def id
          123
        end
      end
    end
  end

  before :each do
    @dummy_class = DummyClass.new

    @base_path = MailTracker::Engine.config.action_mailer.default_url_options[:host]
    @base_url = 'http://' + @base_path + '/'
  end

  it 'should generate appropriate tracking url without original url' do
    url = @dummy_class.tracking_url(MailTracker::Kind::OPEN)
    url.should be_present
    @base_url.should be_present
    url.should include @base_url
    url_without_host = url.gsub(@base_url, '').split('/')
    url_without_host[0].should == 'tracking'
    url_without_host[1].to_i.should == @dummy_class.email.id
    url_without_host[2].to_i.should == MailTracker::Kind::OPEN
    url_without_host[3].should be_nil
  end

  it 'should generate appropriate tracking url with original url' do
    some_url = 'http://lololo.com'
    url = @dummy_class.tracking_url(MailTracker::Kind::CLICK, some_url)
    url.should be_present
    url.should include @base_url
    url_without_host = url.gsub(@base_url, '').split('/')
    url_without_host[0].should == 'tracking'
    url_without_host[1].to_i.should == @dummy_class.email.id
    url_without_host[2].to_i.should == MailTracker::Kind::CLICK
    url_without_host[3].should == ERB::Util::url_encode(some_url)
    url_without_host[4].should be_nil
  end

end