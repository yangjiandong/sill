class Post < ActiveRecord::Base
  # 假删除标注
  #acts_as_paranoid  

  acts_as_archive

  # 记录维护历史
end
