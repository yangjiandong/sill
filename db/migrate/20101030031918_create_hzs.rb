class CreateHzs < ActiveRecord::Migration
  def self.up
    create_table :t_hzk, :id => false do |t|
      t.column :hz, :string, :limit => 10
      t.column :py, :string, :limit => 10
      t.column :wb, :string, :limit => 10
    end

    if Hz.connection.adapter_name.downcase == 'mysql'
      inserts = []
      file = File.open("#{RAILS_ROOT}/db/seeds/hzk.yml", 'r')
      YAML::load(file).each do |k,record|
        # ["hzk_001", {"hz"=>"啊", "py"=>"A", "wb"=>"BS"}]
        inserts.push "('#{record['hz']}','#{record['py']}','#{record['wb']}')"
      end
      # for mysql 是快
      # 0.05s
      sql = "INSERT INTO t_hzk (hz,py,wb) VALUES #{inserts.join(", ")}"
      Hz.connection.execute sql 
    else
      # use ActiveRecord::Extensions
      columns = [:hz, :py, :wb]
      values = []
      
      file = File.open("#{RAILS_ROOT}/db/seeds/hzk.yml", 'r')
      YAML::load(file).each do |k,record|
        # ["hzk_001", {"hz"=>"啊", "py"=>"A", "wb"=>"BS"}]
        # one by one insert ecord
        # mssql use 40s
        #Hz.create!(record)
        values.push "['#{record['hz']}','#{record['py']}','#{record['wb']}']"

      end
      Hz.import columns, values
    end
  end

  def self.down
    drop_table :t_hzk
  end

  private
  class Hz < ActiveRecord::Base
    set_table_name 't_hzk'
  end
end
