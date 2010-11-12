Sill - rails3
=============

2010.11.12
-----------

   1. rails new sill -T

   2. 产生第一个后台表
   rails generate migration create_user

   3. 增加git仓库 http://github.com/yangjiandong/sill

   git remote add origin git@github.com:yangjiandong/sill.git

   git push origin master:refs/heads/master

   $ ssh-keygen
    (ssh-keygen -C "你的email地址" -t rsa)
    Generating public/private rsa key pair.
    Enter file in which to save the key (/Users/schacon/.ssh/id_rsa):
    Enter passphrase (empty for no passphrase):
    Enter same passphrase again:
    Your identification has been saved in /Users/schacon/.ssh/id_rsa.
    Your public key has been saved in /Users/schacon/.ssh/id_rsa.pub.
    The key fingerprint is:
    43:c5:5b:5f:b1:f1:50:43:ad:20:a6:92:6a:1f:9a:3a schacon@agadorlaptop.local

   提交时，需将ssh-key 加到 github

   4. 参考 sonar 采用

   https://github.com/technoweenie/restful-authentication
   vendor/plugins/restful_authentication
   initializers/site_keys.rb

   5. rails应用中本地时间 
Ruby代码 
class ApplicationController < ActionController::Base  
  
  before_filter :set_timezone  
  
  def set_timezone  
    # current_user.time_zone #=> 'London'  
    Time.zone = current_user.time_zone  
  end  
end  

   --END
