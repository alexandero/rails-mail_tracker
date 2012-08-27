class CreateMailTrackerTables < ActiveRecord::Migration
  def self.up
    SCHEMA_AUTO_INSERTED_HERE
  end

  def self.down
    drop_table :mail_tracker_mail
    drop_table :mail_tracker_activities
  end
end
