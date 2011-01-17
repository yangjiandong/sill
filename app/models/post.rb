require 'track_history'

class Post < ActiveRecord::Base
  # 假删除标注
  #acts_as_paranoid

  #acts_as_archive in slqite3 no success
  # acts_as_archive

  # 记录维护历史
  track_history

end
