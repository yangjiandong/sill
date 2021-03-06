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
      # 0.05s,0.5s
      sql = "INSERT INTO t_hzk (hz,py,wb) VALUES #{inserts.join(", ")}"
      Hz.connection.execute sql

    elsif Hz.connection.adapter_name.downcase == 'mssql'
      # 分1000条插入,不然报内存不够.效果没mysql好,还需30s
      inserts = []
      i=0
      file = File.open("#{RAILS_ROOT}/db/seeds/hzk.yml", 'r')
      YAML::load(file).each do |k,record|
        if (i == 0)
          inserts =[]
        end
        i = i + 1

        # ["hzk_001", {"hz"=>"啊", "py"=>"A", "wb"=>"BS"}]
        inserts.push " UNION ALL SELECT '#{record['hz']}','#{record['py']}','#{record['wb']}' "
        if (i == 1000)
          # pp inserts

          #ar1 = inserts[0]
          #ar1["UNION ALL SELECT"] = "SELECT"
          inserts[0][" UNION ALL SELECT"] = " SELECT"
          sql = "INSERT INTO t_hzk (hz,py,wb) #{inserts.join(" ")}"
          Hz.connection.execute sql
          i=0
        end
      end
      
      if !inserts.empty?
          # ar1 = inserts[0]
          inserts[0][" UNION ALL SELECT"] = "SELECT"
          sql = "INSERT INTO t_hzk (hz,py,wb) #{inserts.join(" ")}"
          Hz.connection.execute sql
      end

    else

      # use ActiveRecord::Extensions
      # http://www.continuousthinking.com/tags/arext
      # ar-extensions
      #columns = [:hz, :py, :wb]
      #values = []
      #file = File.open("#{RAILS_ROOT}/db/seeds/hzk.yml", 'r')
      #YAML::load(file).each do |k,record|
      #  values.push "['#{record['hz']}','#{record['py']}','#{record['wb']}']"
      #end
      #Hz.import columns, values

      #Crewait.start_waiting

      file = File.open("#{RAILS_ROOT}/db/seeds/hzk.yml", 'r')
      YAML::load(file).each do |k,record|
        # ["hzk_001", {"hz"=>"啊", "py"=>"A", "wb"=>"BS"}]
        # one by one insert ecord
        # mssql use 40s
        Hz.create!(record)

        # Hz.crewait(
          # :hz => record['hz'],
          # :py => record['py'],
        # :wb => record['wb']
        # )

      end
      #Crewait.go!

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
