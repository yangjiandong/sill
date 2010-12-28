class AddSomeCategory < ActiveRecord::Migration
  def self.up

    root = Category.create!(:name => 'Base', :description => '基础数据')
    dict = Category.create!(:name => 'dict', :description => '字典')
    dict.move_to_child_of(root)

    code = Category.create(:name => 'code', :description => '代码维护')
    code.move_to_child_of(root)

    user = Category.create!(:name => 'user', :description => '人员')
    user.move_to_child_of(dict)
    org = Category.create!(:name => 'org', :description => '部门')
    org.move_to_child_of(dict)
    item = Category.create!(:name => 'item', :description => '元件')
    item.move_to_child_of(dict)

    incatcode = Category.create!(:name => 'incatcode', :description => '收入分类')
    incatcode.move_to_child_of(code)
    costcatcode = Category.create!(:name => 'costcatcode', :description => '成本分类')
    costcatcode.move_to_child_of(code)
    
  end

  def self.down
  end
end
