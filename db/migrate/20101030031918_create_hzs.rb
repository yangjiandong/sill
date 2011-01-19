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
      file = File.open("#{RAILS_ROOT}/db/seeds/hzk.yml", 'r')
      YAML::load(file).each do |k,record|
        # ["hzk_001", {"hz"=>"啊", "py"=>"A", "wb"=>"BS"}]
        # mssql use 40s
        Hz.create!(record)
      end
    end
    #records = YAML.load_file("#{RAILS_ROOT}/db/seeds/hzk.yml")
    #records.each{|record| Hz.create(record)}

  end

  def self.down
    drop_table :t_hzk
  end

  private
  def create_class(class_name, superclass, &block)
    klass = Class.new superclass, &block
    Object.const_set class_name, klass
  end

  class Hz < ActiveRecord::Base
    set_table_name 't_hzk'

  end

end
