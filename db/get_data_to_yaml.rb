require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
    :adapter => 'oracle_enhanced',
    :host => '192.168.1.148',
    :port => 1521,
    :database => 'orcl',
    :username => 'fauser',
    :password => 'fauser')

connection = ActiveRecord::Base.connection

file = File.open('get_data_to_ymal.yml','w')
data = connection.select_value('select hz,py,wb from sys_hzk')
i = '000'
file.write data.inject({}){|hash, record|
  hash["data_ymal_#{i.succ!}"] = record
  hash
}.to_yaml
