Sill - rails3
=============

2011.01.16
-----------

   1. acts_as_paranoid 有问题,
   undefined method `destroy_without_callbacks' for class `Post'
   use: https://github.com/winton/acts_as_archive
   or https://github.com/backupify/acts_as_archive 

   rails g migration add_archive

   --sqlite3
   AlsoMigrate error: ActiveRecord::JDBCError: near "LIKE": syntax error:
   CREATE TABLE archived_posts LIKE posts;
   --手工处理
   execute " CREATE TABLE archived_posts (id integer primary key autoincrement not null, title varchar(255), body varchar(255), user_id integer, created_at datetime, updated_at datetime,deleted_at datetime)"
   --destroy 时,没看到效果

   --mysql
   处理hz库导入时间过长394.9380s 

   2. track_history
   rails g migration add_track_histroy
   -- use sqlite3, 程序运行没成功 
   uninitialized constant TrackHistory::ActsAsMethods::HistoryMethods 

2011.01.15
-----------

   1. jruby 1.6rc1, 设置为1.9时,速度确实比1.8快,但程序有以下错误
   lib/active_record/connection_adapters/oracle_enhanced_context_index.rb:132: syntax error, unexpected kDO_BLOCK
   
   jruby1.6rc1(ruby1.8.7):
     jruby -e "t = Time.now; require 'rubygems'; puts Time.now - t"
     平均0.64
     换成1.9(JRUBY_OPTS=--1.9)
     0 OR 0.016

  2. save/annotate.txt

     标注model 表结构

  3. 记录model变更历史,https://github.com/seejohnrun/track_history 
    save\track_history.txt

    gem 'track_history', '0.0.10'
    bundle update

2011.01.14
-----------

   1. jruby gem  删除 .yardoc  目录
   采用 gem update 升级自动产生了该目录，多余

   2. embedded Apache Tomcat
   git clone git://github.com/calavera/trinidad
   cd xxx
   rake trinidad:build 
   cd pkg
   gem install xxx.gem
   --没成功

   jgem install trinidad
   --
$ jruby -S trinidad --config   # it uses config/trinidad.yml
$ jruby -S trinidad --config /etc/default/trinidad/config.yml

   3. jruby1.6rc1
   
官方声明中还列举了以下一些主要特性：

内置剖析器
RubyGems 1.4.2
不再捆绑RSpec
jruby-complete.jar包含1.9标准库
改善嵌入API
此次新增的内置剖析器得到了RedCar作者Dan Lucraft的帮助，
JRuby核心开发者Charles Nutter还发表了一篇博客，通过示例介绍了--profile.flat和--profile.graph这两个新参数的用法：

~/projects/jruby ? jruby --profile.flat -e "def foo; 100000.times { (2 ** 200).to_s }; end; foo"
   
jruby --profile.graph -e "def foo; 100000.times { (2 ** 200).to_s }; end; foo"

   -- get all gems
   jruby -e "t = Time.now; require 'rubygems'; puts Time.now - t"

2011.01.13
-----------

   1. 用acts_as_paranoid 做"假删除" 

rails plugin install git://github.com/technoweenie/acts_as_paranoid.git
rails generate migration add_deleted_at_to_post deleted_at:datetime
rake db:migrate

   在对应model中增加
class Post < ActiveRecord::Base  
  acts_as_paranoid  
end 

   加上后,调用这个模型的destroy方法将不会真正地删除记录,只会将记录从视图上移除
   ,并且在deleted_at里记录当前的时间.
   当然,你可以在find中使用
   with_deleted或only_deleted
   参数得到被隐藏的记录. 

   2. vim 下排版
   gg=G or =}

   3. 文档生成工具
   参考 sinatra-book, thor, maruku
   https://github.com/cypher/sinatra-book.git 

2011.01.12
-----------

   1. ramdisk 加速系统应用
   save/ramdisk.txt

   2. update rubygems, update gems

   gem update --system
   gem update

2011.01.11
-----------

   1. git flow
   https://github.com/nvie/gitflow 

Manual installation(cygwin)

If you prefer a manual installation, please use the following instructions. After downloading the sources from Github, also fetch the submodules:

$ git submodule init
$ git submodule update
Then, you can install git-flow, using:

$ sudo make install

install -m 0644 git-flow-init git-flow-feature git-flow-hotfix git-flow-release git-flow-support git-flow-version gitflo
w-common gitflow-shFlags /usr/local/bin

  注意,最后需将usr/local/bin 下生成的文件考到cygwin/binary

  2. vim
  set ignorecase    " ignore case when searching "
  http://nvie.com/posts/how-i-boosted-my-vim/

2011.01.10
-----------

   1. JRUBY_OPTS=--1.9

   2. attr_accessor_with_default

class Person
  attr_accessor_with_default :age, 25
end

some_person.age    # => 25

some_person.age = 26
some_person.age    # => 26

2011.01.06
-----------

   1. 学习自定义模板
   http://huacnlee.com/blog/how-to-custom-scaffold-templates-in-rails3
   gem "wice_grid", '3.0.0.pre1'  --https://github.com/leikind/wice_grid/tree/rails3,example:http://grid.leikind.org/ 
   gem "simple_form" --https://github.com/plataformatec/simple_form
   lib/templates

   --以下步骤没成功,需手工拷贝文件
   rails g wice_grid_assets_jquery 

   example:
   --生成前台界面
   rails g scaffold Post title:string body:text user_id:integer
   --生成后台
   rails g scaffold_controller admin/post title:string body:text user_id:integer

   --test
   http://localhost:6000/posts 

   --采用html 形式的控制器统一继承ApplicationHtmlController
   --模板中也采用该控制器

   2. vim
  set statusline=%f\ [%{&fenc}\ %{&ff}]\ [%Y]\ [\%03.3b\ \%02.2B]\ [%02v\ %03l\ %L\ %p%%]  
  js format
  map <F5> :call g:Jsbeautify()<CR>

2011.01.04
-----------

   1. sqlserver
   https://github.com/rails-sqlserver/tiny_tds

2011.01.02
-----------

   1. enum 方式
   http://www.javaeye.com/topic/448235

   lib/enum_attr.rb
   example:
   category.rb
   enum_attr :sex, [['男', 0], ['女', 1]]
   # <%= form.select :sex, Category::ENUMS_SEX %>
   # #在显示输出的时候我们可以直接调用扩展方法
   # <%= category.sex_name %>

   另一个插件: https://github.com/jeffp/enumerated_attribute

   -- 感觉不如定义个表存放记录

   2. 在线翻译
   https://github.com/qichunren/acts_as_translatebox/wiki

   访问google来进行翻译

2010.12.30
----------

   1. oracle
   example: https://github.com/rsim/rails3_oracle_sample.git

   --专门建立个oracle环境
   --config/environments/oracle.rb
   http://blog.rayapps.com/2010/09/09/oracle-enhanced-adapter-1-3-1-and-how-to-use-it-with-rails3/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+rayapps_blog+%28Ray%3A%3AApps.blog%29

   rake db:migrate RAILS_ENV=oracle
   rails s -e oracle

   2. 增加数据导出
   rake db:extract_fixtures
   导出目录 db/yml
   --有问题,个别表导不出数据,如t_resources,delayed_jobs

   整个数据库的导入导出,还是用yaml_db
   -- --> db/data.yml
   rake db:dump
   --导入
   rake db:load
   --string 中文导出显示为 !binary,
   --http://groups.google.com/group/rails-i18n/browse_thread/thread/bda8e00bce10cafc
   --hack String(config/initializers/sill.rb)类,也没能正常显示为中文,考虑用ya2ymal

   --一般流程
   1). rake db:dump
   2). Edit config/database.yml and change your adapter to mysql, set up database params
   3). mysqladmin create [database name]
   4). rake db:migrate
   5). rake db:load

   3. 直接导出
   cd db
   jruby get_data_to_yaml.rb
   --采用了ya2ymal,能正常显示为中文

   4. hzk
   rails g model hzk
   migrate 装载初始化数据

    file = File.open("#{RAILS_ROOT}/db/seeds/hzk.yml", 'r')
    YAML::load(file).each do |k,record|
      # ["hzk_001", {"hz"=>"啊", "py"=>"A", "wb"=>"BS"}]
      Hz.create!(record)
    end

    --有关其它装载方法参考 http://stackoverflow.com/questions/3082643/how-to-load-the-data-from-a-yml-file-to-database
    --save/load-data.txt

    5. 一个vim 方案
    https://github.com/carlhuda/janus
    windows 平台上安装不成功
    --windows下不能正常运行command-t需ruby编译安装

2010.12.29
----------

   1. save/oracle.txt

2010.12.28
----------

   1. 参考ext doc, 树形菜单,可查找定位

2010.12.24
----------

   1. gem install ruby-debug
   0.10.4
   http://blog.headius.com/2010/12/jruby-finally-installs-ruby-debug-gem.html

   2. awesome_nested_set 1.2.5 + ror 3.0.3 有问题,
   http://localhost:3000/category/category_tree 不能正常运行(长时间没反应)
   Gemfile 返回 ror 3.0.1

   3. 加速jruby 运行速度
   http://blog.headius.com/2009/05/jruby-nailgun-support-in-130.html
   --好象速度没有变快
   jruby/tool/nailgun/jruby --ng-server
   open other command
   jruby --ng -e 'puts 1'
   jruby --ng script/rails s
   --测试
   jruby --ng -e 'puts Time.now; require "config/environment";puts Time.now'

2010.12.23
----------

   1. rspec

2010.12.22
----------

   1. use jquery
   http://ihower.tw/rails3/restful.html
   save\jquery.rails.js
   首先，我們必須更換 public/javascript/rails.js 的內容為 jQuery 版本，
   這個檔案是 Rails 的 JavaScript driver。
   請下載 http://github.com/rails/jquery-ujs/blob/master/src/rails.js 覆蓋至 /public/javascript/rails.js
   接著，我們需要 jQuery。請 下載 jQuery 至 /public/javascript/jquery.js，然後修改 config/application.rb 將以下註解移除
   config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

2010.12.21
----------

   1.  建立branch use.prototype.js
   git branch use.prototype.js
   git push origin use.prototype.js

   master 采用extjs

   2. 采用mongrel,
   另一个server,>gem install eventmachine-0.12.10-java.gem
   高并发时有得一拼：http://www.rubyinside.com/thin-a-ruby-http-daemon-thats-faster-than-mongrel-688.html

   3. 采用mvn jetty方式运行，页面压缩率没有mongrel 高
   通过对login页面的对比：
文档 (1 文件)	2 KB (2 KB 解压的)
  http://localhost:9001/dev/login	2 KB (2 KB 解压的)
  图片 (1 文件)	21 KB
  http://localhost:9001/dev/images/favicon.ico?1291723898	21 KB
  对象 (0 文件)
  脚本 (2 文件)	101 KB (1430 KB 解压的)
  http://localhost:9001/dev/javascripts/ext/ext-all-debug.js?1292636297	54 KB (1336 KB 解压的)
  http://localhost:9001/dev/javascripts/ext/adapter/ext/ext-base-debug.js?1292636297	47 KB (94 KB 解压的)
  样式表 (1 文件)	68 KB (136 KB 解压的)
  http://localhost:9001/dev/javascripts/ext/resources/css/ext-all.css?1292636297	68 KB (136 KB 解压的)
  总计	192 KB (1589 KB 解压的)

文档 (1 文件)	2 KB (2 KB 解压的)
  http://localhost:3000/login	2 KB (2 KB 解压的)
  图片 (1 文件)	8 KB
  http://localhost:3000/images/favicon.ico?1291723898	8 KB
  对象 (0 文件)
  脚本 (2 文件)	12 KB (1430 KB 解压的)
  http://localhost:3000/javascripts/ext/ext-all-debug.js?1292636297	8 KB (1336 KB 解压的)
  http://localhost:3000/javascripts/ext/adapter/ext/ext-base-debug.js?1292636297	4 KB (94 KB 解压的)
  样式表 (1 文件)	96 KB (136 KB 解压的)
  http://localhost:3000/javascripts/ext/resources/css/ext-all.css?1292636297	96 KB (136 KB 解压的)
  总计	118 KB (

   4. link

On Linux, Unix or Mac OS X systems create a symbolic link named typo3_src
pointing to the source package:
  ln -s /var/www/typo3_src-4.3.0 /var/www/example.com/typo3_src

On Windows Vista or Windows 7 create a symbolic link named typo3_src
pointing to the source package:
  mklink /D C:\<dir>\typo3_src-4.3.0 C:\<dir>\example.com\typo3_src

Users of Windows XP/2000 can use the "junction" program by Marc Russinovich to
create links. The program can be obtained at:
  http://technet.microsoft.com/en-us/sysinternals/bb896768.aspx
Use junction to list junctions:
Usage: [-s]
-s    Recurse subdirectories
Examples:
To determine if a file is a junction, specify the file name:
junction c:\test
To list junctions beneath a directory, include the –s switch:
junction -s c:\
To create a junction c:\Program-Files for "c:\Program Files":
C:\>md Program-Files
C:\>junction c:\Program-Files "c:\Program Files"
To delete a junction, use the –d switch:
junction -d c:\Program-Files


2010.12.20
----------

   1. 另一个高并发项目 ,采用了akka
    https://github.com/danielribeiro/RubyOnAkka
    -- 没成功

   2. 项目:https://github.com/flyerhzm/rails-bestpractices.com
    -- 环境为linux,

   3. bullet
    开发过程中收集query,提供改进信息
    https://github.com/flyerhzm/bullet
    -- mvn 环境下不能正常运行,jruby on rails下能运行.

   4. 采用jruby1.5.6 + jruby rack 1.0.4

   5.  Can restful authentication work with Cookies Disabled?
   http://stackoverflow.com/questions/1514774/can-restful-authentication-work-with-cookies-disabled

   add to lib\authenticate_system.rb
   --好像多余,已实现

2010.12.18
----------

   1. 另一种debug 方法

   lib/debug_log, sill.rb增加设置:
   ActionController::Base.send(:include, DebugLog)
   ActiveRecord::Base.send(:include, DebugLog)

   Based on the code above, made the plugin debug_logger.
   How to use:
   in model or controller
   debug_log("anything")

   log文件存放在log/debug.log
   tail debug.log 可跟踪显示.
   --实时显示log信息
   tail debug.log -f

   2. rspec

   save/rspec.txt

   3. 后台任务
   https://github.com/ncr/background-fu
   采用plugin 方式,
   save\background.txt

   rails plugin install git://github.com/ncr/background-fu.git
   rails g background
   --需修改下background-fu/rails/init.rb
   --jruby script/background start 不成功

   另一个方案
   http://github.com/collectiveidea/delayed_job
   gem 'delayed_job'

   jruby script/rails generate delayed_job
   rake db:migrate
   --run
   rake jobs:work

   --配置
   initializers/delayed_job_config.rb

   相关信息:
   http://asciicasts.com/episodes/171-delayed-job
   http://blog.plataformatec.com.br/2010/02/monitoring-delayed-job-with-bluepill-and-capistrano/

   4. 如何格式化"12345"为"12,345"
javascript:
Js代码
string.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, function(s){return s+","})

ruby:
Ruby代码
string.gsub(/(\d)(?=(\d\d\d)+(?!\d))/) { |match| match + ',' }


2010.12.17
----------

   1. production log 采用 log4j

   production.rb:

   require File.dirname(__FILE__) + '/../../lib/slf4j_logger.rb'
   config.logger = Slf4jLogger.new
   ActiveRecord::Base.logger = config.logger

   logback.xml:
  <!-- JRuby on Rails. Uncomment in order to log HTTP and SQL requests -->
  <logger name="rails">
    <level value="ERROR"/>
  </logger>

2010.12.16
----------

   1. chart - highcharts
   https://github.com/stonegao/lazy_high_charts

2010.12.15
----------

   1. extjs/direct
   https://github.com/extjs/direct-rails.git
   or
   https://github.com/stonegao/active-direct

   2. acts_as_nested_set
   http://www.javaeye.com/topic/76860
   改用: rails plugin install git://github.com/galetahub/awesome_nested_set.git
   save/ Awesome Nested Set Cheat Sheet.txt

   cd src\main\webapp\WEB-INF
   rails generate migration create_categories
   rake db:migrate

2010.12.14
----------

   1. 采用页面缓存时,由于jetty运行配置中设置了webpath 为 dev,所以统一放到webapp/dev下

2010.12.13
----------

   1. 感觉还是要用extjs,倒底它提供了全套的界面解决方案,不像jquery,prototype,只是个框架,并且应用起来还要考虑插件所依靠的版本问题.

   2. 建立branch use.prototype.js
   git branch use.prototype.js
   git push origin use.prototype.js

   3. 引入ext3.3.0
   public/javascripts/ext(ext/adapter,resources,ext-all.js,ext-all-debug.js,ext-lang-zh_CN.js),
                      ext.ux(ext/examples/ux)
   --不包含到git

   4. name shrek
   http://www.google.com/images?hl=en&q=shrek&um=1&ie=UTF-8&source=univ&ei=gQIGTZGWBYOsrAezhPmQDw&sa=X&oi=image_result_group&ct=title&resnum=8&ved=0CHsQsAQwBw&biw=1239&bih=754

   5. 参考 extrails,
   http://sourceforge.net/projects/extrails/

2010.12.12
----------

   1. jetty 运行时,html,js文件不能编辑
http://www.assembla.com/wiki/show/liftweb/Fix_file_locking_problem_with_jettyrun
Files are locked on Windows and can't be replaced
old:http://docs.codehaus.org/display/JETTY/Files+locked+on+Windows

   <servlet>
    <servlet-name>default</servlet-name>
    <init-param>
      <param-name>useFileMappedBuffer</param-name>
      <param-value>false</param-value>
    </init-param>
  </servlet>

  或采用webdefault.xml,pom.xml设置
  <webDefaultXml>${basedir}/src/dev/webdefault.xml</webDefaultXml>
  --没效果,在sshapp项目上用时起作用

   2. prototip 1.0.2 在 rails3 自带prototype 1.7.2 的环境中不能运行

   prototip最新版2.2.2在ie8,chrome下不能正常显示
   暂时用1.3.5
   http://www.nickstakenburg.com/projects/prototip/
   --也有问题,显示不完整

   3. 简单 tooltip
   http://rafael.adm.br/p/simple-tooltip-helper-for-ruby-on-rails/

   4. How to enable multi-threading in rails
To enable thread-safe (multi-threaded) mode in Rails when running with a warbler-generated WAR file:

set min/max runtimes in warble.rb to 1/1 respectively
in config/environment.rb put the line config.threadsafe!
When running with the GlassFish gem, threadsafe mode will be detected automatically and GlassFish will use only a single JRuby instance. As a result only step 2 above is necessary.

   http://kenai.com/projects/jruby/pages/RailsMulti-ThreadingBestPractices/revisions/2

2010.12.10
----------

   1. 在ChartsServlet中硬编码charts

2010.12.09
----------

   1. 加入sonar项目中platform概念

   pom.xml
   replace commons-logging by jcl-over-slf4j

2010.12.08
----------

   1. 怪异现象,用mvn jetty:run 报:
   org.jruby.rack.RackInitializationException: No such file or directory - D:/workspace/jruby/config/database.yml|...

   打包生成war,放到tomcat,运行正常.
   将整个项目移到其它地方d:\a\sill.mvn,配置下config/database.yml development数据源,就能正常.
   原来目录为 d:\workspace\jruby\workspace\sill.mvn\

2010.12.07
----------

   1.  采用mvn.
      cd parent
      mvn install
      cd ..
      mv eclipse:eclipse

      jruby-rack 暂时用1.0.1, 1.0.3 有bug,jetty下不能显示,首页为浏览目录.
      --可采用index.html解决
      --现采用jruby 1.5.6, jruby-rack 1.3.0

   2. webapp/WEB-INF/gems 不加入版本

   3、手工建立eclipse项目

   a、建立m2_home变量
     mvn -Declipse.workspace=<path-to-eclipse-workspace> eclipse:add-maven-repo
   b、生成eclipse项目
     mvn eclipse:eclipse
     bin/eclipse.bat

   4. 生成演示数据
   --yaml_db 在rails2.3 中有点问题,具体看jrails/doc/readme.txt

   拷贝yaml_db到lib下
   rake db:dump --> db/data.yml

2010.12.06
----------

   1. 性能

   d:\xampp1.6.8\apache\bin\ab -n 10 -c 5 http://127.0.0.1:8080/sill/login
   --5 个并发,10个请求
   --与jruby.min.runtimes 设置有关,min,max全为1时,时间最短,max 10 ,时间很慢
   --2,4 也还行.但还找不到规律,时快时慢,最后能稳定到300多
   https://github.com/nicksieger/jruby-rack
   For multi-threaded Rails with a single runtime, set min/max both to 1

   2. User

    include NeedAuthentication::ForUser

    def self.included(recipient)
      recipient.extend(ModelClassMethods)
    end

    扩展类方法(class method),这样User可直接用authenticate(login,password), editable_password? 方法
    --具体参考 http://www.javaeye.com/topic/470421

    sessions_controller.login
    ..
      User.authenticate(login, password)
    ..

   3. simple-navigation
   gem "simple-navigation"
   and run
   bundle install

   rails generate navigation_config

2010.12.05
----------

   1. cache
   production.rb文件中添加下面的代码：

config.action_controller.perform_caching = true
config.action_controller.cache_store = :file_store, RAILS_ROOT+"/tmp/cache/"
config.action_controller.page_cache_directory = RAILS_ROOT+"/public/cache/"

   然后在控制器中定义你要缓存的页面

caches_page :index, :help, :home, :faq
   这样就可以了， 下一次你不用请求rails服务器就能访问到这些页面了

   这只是一个基本用法， 更多信息请移步：
http://guides.rubyonrails.org/caching_with_rails.html

   --经试验
config.action_controller.cache_store = :file_store, RAILS_ROOT+"/tmp/cache/"
config.action_controller.page_cache_directory = RAILS_ROOT+"/public/cache/"
没效果,产生的文件一直放在public/下

   --总结,程序对关键数据少用cache,自定义APP_CACHE,通过程序来读写,另一类是rails设置的cache,
   通过development,production环境中设置,建议只对静态文件设置cache

   2. Users Delete 连接,页面必须增加
   <%= csrf_meta_tag %>,
   并且增加rails3其他js类库

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

   注意,bundle一般bundle install即可,Gemfile改动后才bundle update

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
