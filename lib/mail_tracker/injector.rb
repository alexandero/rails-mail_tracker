require File.expand_path('../kind', __FILE__)
require File.expand_path('../url_helper', __FILE__)
require 'nokogiri'

module MailTracker
  class Injector

    include MailTracker::UrlHelper

    def self.process(message)
      parts = (message.multipart?) ? message.parts : [message]
      html_parts = parts.select { |part| /text\/html/ === part.content_type }
      new(message, html_parts) unless html_parts.empty?
    end

    attr_reader :message,
                :email

    def initialize(message, parts)
      @message = message
      @email = MailTracker::Email.create! :message_id => message.message_id
      parts.each { |part| inject_code!(part) }
    end

    private

      def inject_code!(part)
        doc = Nokogiri::HTML(part.body.decoded)
        doc.css('a').each do |link|
          link['href'] = tracking_url(::MailTracker::Kind::CLICK, link['href'])
        end
        doc.at_css('body').add_child tracking_image
        part.body = doc.to_html
      end

      def tracking_image
        %Q[<img src="#{tracking_url(::MailTracker::Kind::OPEN)}" alt="" width="1" height="1" />]
      end

  end
end