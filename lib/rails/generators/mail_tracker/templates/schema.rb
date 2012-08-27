ActiveRecord::Schema.define(:version => 0) do

  create_table :mail_tracker_emails do |t|
    t.string :message_id
    t.timestamps
  end

  create_table :mail_tracker_activities do |t|
    t.integer :email_id, :null => false
    t.integer :kind, :null => false
    t.string  :origin_url, :default => '', :null => false
    t.integer :qty, :null => false
    t.timestamps
  end

  add_index :mail_tracker_activities, :email_id
  add_index :mail_tracker_activities, [:email_id, :kind, :origin_url], :name => :index_on_email_id_and_kind_and_origin_url

end