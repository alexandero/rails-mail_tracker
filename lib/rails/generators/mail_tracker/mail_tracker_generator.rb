require 'rails/generators'
require 'rails/generators/migration'

class MailTrackerGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    File.expand_path(File.join('templates'), File.dirname(__FILE__))
  end
   
  def self.next_migration_number(dirname) #:nodoc:
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end


  # Every method that is declared below will be automatically executed when the generator is run
  
  def create_migration_file
    f = File.open File.join(File.dirname(__FILE__), 'templates', 'schema.rb')
    schema = f.read; f.close
    
    schema.gsub!(/ActiveRecord::Schema.*\n/, '')
    schema.gsub!(/^end\n*$/, '')

    f = File.open File.join(File.dirname(__FILE__), 'templates', 'migration.rb')
    migration = f.read; f.close
    migration.gsub!(/SCHEMA_AUTO_INSERTED_HERE/, schema)
    
    tmp = File.open "tmp/~migration_ready.rb", "w"
    tmp.write migration
    tmp.close

    migration_template  '../../../tmp/~migration_ready.rb',
                        'db/migrate/create_mail_tracker_tables.rb'
    remove_file 'tmp/~migration_ready.rb'
  end

  def copy_initializer_file
    copy_file 'initializer.rb', 'config/initializers/mail_tracker.rb'
  end

end
