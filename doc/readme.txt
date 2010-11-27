Sill - rails3
=============

2010.11.27
-----------
 
   1. jruby-memcache-client change to dalli

2010.11.22
-----------

   1. rails3 route
   match "/about" => "info#about", :as => :about  
   没有:as参数，这个路由就是单纯的转向"/about", 加了:as 之后，在我们的应用里面可以使用about_path或者about_url

2010.11.20
-----------
   
   1. haml 掌握有难度,暂时用erb,参考images,javascripts,stylesheets

2010.11.15
-----------

   1. sqlite3 -line db/development.sqlite3
   会以比较优雅的格式显示查询

   2. haml form example
#login_format
  - form_tag session_path do
    %p= label_tag 'login'
    %br
    = text_field_tag 'login', @login
    %p= label_tag 'password'
    %br/
    = password_field_tag 'password', nil
    %p= label_tag 'remember_me', 'Remember me'
    = check_box_tag 'remember_me', '1', @remember_me
    %p= submit_tag 'Log in'

- form_tag('/') do
  - [1, 2, 3].each do |i|
    = check_box_tag "accept#{i}"
  = submit_tag

-- login
  %form{:controller =>'sessions',:action => 'login', :method =>"post", :html => "onsubmit$('commit').disabled = true"}
    .title= '::登录'
    .section
      .label= '登录名:'
      = text_field_tag :login
      .label= '密码:'
      = password_field_tag :password

    %div(style="margin-left:12px") #{check_box_tag(:remember_me)} #{'记忆密码'}
    %br
    .buttonbar
      = submit_tag ' 登录'

2010.11.14
-----------

   1. 格式化输出信息,ap,参考fat_crm,增加awesome_print
   https://github.com/michaeldv/awesome_print

2010.11.12
-----------

   1. rails new sill -T
   --跳过测试

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

   https://github.com/Satish/restful-authentication
   (https://github.com/technoweenie/restful-authentication)
   vendor/plugins/restful_authentication
   initializers/site_keys.rb

   5. 显示本地时间
   rake time:zones:local

   数据库:
config.active_record.default_timezone = :local
config.active_record.time_zone_aware_attributes = false
config.time_zone = nil

   --END
