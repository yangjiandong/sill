class CreateAddonsPosts < ActiveRecord::Migration
  def self.up
    create_table :addons_posts, :id => false  do |t|
      t.string :id, :limit => 36, :null => false
      t.string :title

      t.timestamps
    end
    add_index(:addons_posts, :id)

    Addons::Post.create(:title => '使用uuid')
    Addons::Post.create(:title => '考虑使用jruby rails')
    Addons::Post.create(:title => '今年收入增加了没有')
    Addons::Post.create(:title => '明年做什么')
    Addons::Post.create(:title => '使用u收到饿是谔谔的饿')
  end

  def self.down
    drop_table :addons_posts
  end
end
