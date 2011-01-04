class CreateResources < ActiveRecord::Migration
  def self.up
    create_table 't_resources' do |t|
      t.integer :parentid, :null => false
      t.string :resname, :limit => 40
      t.string :restype, :limit => 1
      t.string :iconcls, :limit => 40 
      t.string :resurl, :limit => 100
      t.string :description, :limit => 100
      t.integer :orderNo

      t.timestamps
    end

    create_table 't_groups_resources', :id => false do |t|
      t.integer :resource_id
      t.integer :group_id
    end

    module1 = Resource.create!(:parentid => 0, :resname => '系统管理', :restype => '0', :iconcls => 'applicationIcon', :description => '系统管理模块', :orderNo => 1)
    module2 = Resource.create!(:parentid => 0, :resname => '收费管理', :restype => '0', :iconcls => 'applicationIcon', :description => '收费管理模块', :orderNo => 2)
   
    submenu1 = Resource.create!(:parentid => module1.id, :resname => '基础字典', :restype => '1', :iconcls => '', :description => '基础字典菜单',:orderNo => 1)
    menu1 =  Resource.create!(:parentid => submenu1.id, :resname => '分类字典', :restype => '2', :iconcls => 'bookIcon', :resurl => 'dicts', :orderNo => 1)
    menu2 =  Resource.create!(:parentid => submenu1.id, :resname => '人员管理', :restype => '2', :iconcls => 'userIcon', :resurl => 'users', :orderNo => 2)
  end

  def self.down
    drop_table 't_resources'
    drop_table 't_groups_resources'
  end
end
