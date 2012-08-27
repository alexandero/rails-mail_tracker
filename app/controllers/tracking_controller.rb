module MailTracker
  class TrackingController < ::ActionController::Base
    def create
      email = MailTracker::Email.find params[:email_id]
      attrs = { :origin_url => params[:origin_url].to_s, :kind => params[:kind] }
      # TODO: use insert or update
      activity = email.activities.where(attrs).first
      if activity
        activity.qty += 1
        activity.save!
      else
        email.activities.create! attrs.merge(:qty => 1)
      end

      params[:origin_url] ? redirect_to(params[:origin_url]) : render(:nothing => true)
    end
  end
end