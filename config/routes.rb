Rails.application.routes.draw do

  scope MailTracker::Engine.config.mount_at do
    match 'tracking/:email_id/:kind(/:origin_url)' => 'mail_tracker/tracking#create',
          :as => :mail_tracking,
          :constraints => { :origin_url => /\S*/ }

  end

end
