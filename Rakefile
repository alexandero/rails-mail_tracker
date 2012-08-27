require 'rake'
require 'yaml'
require 'mysql2'
require 'active_record'

namespace :db do

  task :connect do
    config_list = YAML::load(File.read(File.expand_path(File.join('spec/database.yml'), File.dirname(__FILE__))))
    @config = config_list['test']
    @client = Mysql2::Client.new(:host => @config['host'],
                                 :username => @config['username'],
                                 :password => @config['password'])
  end

  desc 'load db schema'
  task :load_schema => :connect do
    @client.query("CREATE DATABASE IF NOT EXISTS #{@config['database']}")

    ActiveRecord::Base.establish_connection @config
    ActiveRecord::Base.connection

    load(File.expand_path(
             File.join("lib/rails/generators/mail_tracker/templates/schema.rb"),
             File.dirname(__FILE__)))
  end

  desc 'drop db schema'
  task :drop_schema => :connect do
    @client.query("DROP DATABASE IF EXISTS #{@config['database']}")
  end

  desc 'reset db schema'
  task :reset_schema => [:drop_schema, :load_schema]

end
