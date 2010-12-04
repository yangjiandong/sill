Sill - rails3
=============

2010.12.04
----------

   1. 教训,rails3中route采用restful,必须用
   resources :users
   以前参考sonar,用了resource :users,rake routes时,不显示index,并且edit路径为edit_users

   2. warble

   bundle unlock
   bundle install
   bundle update
   bundle lock

   warble config
   warble
   --运行报错时,查看下tomcat/log

   运行时会对调用的rb进行编译,所以对代码质量要求比较高,现报以下错:
   org.jruby.rack.RackInitializationException: private method `scan' called for nil:NilClass
  from D:/apache-tomcat-6.0.18/apache-tomcat-6.0.18/webapps/sill/WEB-INF/lib/database_version.rb:42:in `uptodate?'
  from D:/apache-tomcat-6.0.18/apache-tomcat-6.0.18/webapps/sill/WEB-INF/lib/database_version.rb:64:in `automatic_setup'
  from D:/apache-tomcat-6.0.18/apache-tomcat-6.0.18/webapps/sill/WEB-INF/config/environment.rb:44
  from D:/apache-tomcat-6.0.18/apache-tomcat-6.0.18/webapps/sill/WEB-INF/config/environment.rb:239:in `require'
    ...

  找到原因了,werble生成war时,没有把db目录带过去


2010.12.02
-----------

   1. haml
   ren _info.html.erb to _info.html.haml
   -- 参考 html2haml _info.html.erb

   2. multi database
   model:
   establish_connection "oracle_#{RAILS_ENV}"
   establish_connection :oracle_development

   3. ruby map(&:id)
   --http://stackoverflow.com/questions/1217088/what-does-mapname-mean-in-ruby
/* tags.map(&:name).join(' ') */
/* def tag_names */
/* @tag_names || tags.map { |tag| tag.name }.join(' ') */
/* end */

   4. symbol 操作
   include? 是否包含指定的symbol
   contact  连接指定的symbol

2010.11.30
-----------

   1. 数据导入、导出
   rake db:data dump
   rake db:data load

   2. 新增表 t_properties
   rails generate migration create_properties_table
   rake db:migrate
   --新增字段resource_id,重新做
   --rake db:migrate version=20101128123131

2010.11.28
-----------

   1. peepcode-code-review.pdf
   session in db
   # (create the session table with "rake db:sessions:create")
   Sill::Application.config.session_store :active_record_store

   自定义lib/tasks/sessions.rake
   两个任务,
   rake sessions:count
   rake sessions:prune RAILS_ENV=production

   2. add plugin :acts_as_tree

   https://github.com/parndt/acts_as_tree

   3. add group model
   rails generate migration create_group

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
