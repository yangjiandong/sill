# 菜单资源,只用到三级,第一级为模块,第二级为子菜单,第三级为连接

class Resource < ActiveRecord::Base
  set_table_name 't_resources'

  has_and_belongs_to_many :groups, :class_name => 'Group', :join_table => 't_groups_resources'

end

# == Schema Information
#
# Table name: t_resources
#
#  id          :integer(10)     not null, primary key
#  parentid    :integer(10)     not null
#  resname     :string(40)
#  restype     :string(1)
#  iconcls     :string(40)
#  resurl      :string(100)
#  description :string(100)
#  orderNo     :integer(10)
#  created_at  :datetime(23)
#  updated_at  :datetime(23)
#

