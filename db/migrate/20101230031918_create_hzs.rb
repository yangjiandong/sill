class CreateHzs < ActiveRecord::Migration
  def self.up
    create_table :t_hzk, :id => false do |t|
      t.column :hz, :string, :limit => 10
      t.column :py, :string, :limit => 10
      t.column :wb, :string, :limit => 10
    end

    file = File.open("#{RAILS_ROOT}/db/seeds/hzk.yml", 'r')
    YAML::load(file).each do |k,record|
      # ["hzk_001", {"hz"=>"啊", "py"=>"A", "wb"=>"BS"}]
      Hz.create!(record)
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
