# 菜单资源,只用到三级,第一级为模块,第二级为子菜单,第三级为连接

class Resource < ActiveRecord::Base
  set_table_name 't_resources'

  has_and_belongs_to_many :groups, :class_name => 'Group', :join_table => 't_groups_resources'

end
