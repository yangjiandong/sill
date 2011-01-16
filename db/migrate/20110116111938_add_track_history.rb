class AddTrackHistory < ActiveRecord::Migration
  def self.up
    # case connection.adapter_name.downcase
    # when 'sqlite'
      # execute " CREATE TABLE post_histories 
      # (id integer primary key autoincrement not null, 
      # post_id integer, 
      # title_before varchar(255),
      # title_after varchar(255),
      # created_at datetime)"

    # else
    create_table 'post_histories' do |t|
      t.column :post_id, :integer
      t.column :title_before,  :string, :limit => 255
      t.column :title_after, :string, :limit => 255
      t.column :created_at, :datetime
    # end
      
    end
  end

  def self.down
    drop_table 'post_histories'
    #execute " drop table post_histories"
  end
end
