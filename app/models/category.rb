require 'awesome_nested_set'

class Category < ActiveRecord::Base
  set_table_name 't_categories'
  # rails plugin install git://github.com/galetahub/awesome_nested_set.git 
  acts_as_nested_set
  
  # 测设enum_attr的DSL语法
  # enum_attr :sex, [['男', 0], ['女', 1]]

  Category.include_root_in_json = false if Category.respond_to?(:include_root_in_json)
  
  def leaf?
    if self.rgt - self.lft == 1
      return true
    else
      return false
    end
    
  end
end

# == Schema Information
#
# Table name: t_categories
#
#  id          :integer(10)     not null, primary key
#  name        :string(40)      not null
#  parent_id   :integer(10)
#  lft         :integer(10)
#  rgt         :integer(10)
#  description :string(100)
#  depth       :integer(10)
#  created_at  :datetime(23)
#  updated_at  :datetime(23)
#

