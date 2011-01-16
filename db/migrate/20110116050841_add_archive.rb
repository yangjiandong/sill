class AddArchive < ActiveRecord::Migration
  def self.up
    #transaction do
    
    case connection.adapter_name.downcase
    when 'sqlite'
      execute " CREATE TABLE archived_posts (id integer primary key autoincrement not null, title varchar(255), body varchar(255), user_id integer, created_at datetime, updated_at datetime,deleted_at datetime)"

    else 
      ActsAsArchive.update Post
    end
     # Post.create_archive_table
    #end
  end

  def self.down
    #Post.drop_archive_table
  end
end
