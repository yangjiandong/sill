# encoding: UTF-8
$KCODE = 'UTF8' unless RUBY_VERSION >= '1.9'
require 'rubygems'
require 'active_record'
require 'ya2yaml'

ActiveRecord::Base.establish_connection(
    :adapter => 'oracle_enhanced',
    :host => '192.168.1.148',
    :port => 1521,
    :database => 'orcl',
    :username => 'fauser',
    :password => 'fauser')

connection = ActiveRecord::Base.connection

file = File.open('yml/hzk_ymal.yml','w')
data = connection.select_all('select hz,py,wb from sys_hzk')
i = '000'
file.write data.inject({}){|hash, record|
  hash["hzk_#{i.succ!}"] = record
  hash
}.ya2yaml(:syck_compatible => true)
