#
# 设置信息
class Property < ActiveRecord::Base
  set_table_name 't_properties'

  def key
    prop_key
  end

  def value
    text_value
  end

  def self.hash(resource_id=nil)
    hash={}
    Property.find(:all, :conditions => {'resource_id' => resource_id, 'user_id' => nil}).each do |prop|
      hash[prop.key]=prop.value
    end
    hash
  end


  def self.value(key, resource_id=nil, default_value=nil)
    prop=Property.find(:first, :conditions => {'prop_key' => key, 'resource_id' => resource_id, 'user_id' => nil})
    prop ? prop.text_value : default_value
  end

  def self.values(key, resource_id=nil)
    Property.find(:all, :conditions => {'prop_key' => key, 'resource_id' => resource_id, 'user_id' => nil}).collect{|p| p.text_value}
  end

  def self.set(key, value, resource_id=nil)
    Property.delete_all('prop_key' => key, 'resource_id' => resource_id, 'user_id' => nil)
    Property.create(:prop_key => key, :text_value => value.to_s, :resource_id => resource_id)
    reload_java_configuration
  end

  def self.clear(key, resource_id=nil)
    Property.delete_all('prop_key' => key, 'resource_id' => resource_id, 'user_id' => nil)
    reload_java_configuration
  end

  def self.by_key(key, resource_id=nil)
    Property.find(:first, :conditions => {'prop_key' => key, 'resource_id' => resource_id, 'user_id' => nil})
  end

  def self.by_key_prefix(prefix)
    Property.find(:all, :conditions => ["prop_key like ?", prefix + '%'])
  end

  def self.update( key, value )
    property = Property.find(:first, :conditions => {:prop_key => key, :resource_id => nil, :user_id => nil});
    property.prop_value = value
    property.save
    reload_java_configuration
    property
  end

  def to_hash_json
    {:key => key, :value => value.to_s}
  end

  def to_xml(xml=Builder::XmlMarkup.new(:indent => 0))
    xml.property do
      xml.key(prop_key)
      xml.value {xml.cdata!(prop_value.to_s)}
    end
    xml
  end

  def self.get_database_date
    sql = ActiveRecord::Base.connection();
    #Rails.logger.info(sql.adapter_name)
    if sql.adapter_name == "MsSQL"
      #sql.execute "SET autocommit=0";
      #sql.begin_db_transaction
      rows = sql.select_one("Select CONVERT(varchar(100), GETDATE(), 102) as value");
      #sql.commit_db_transaction
      #Rails.logger.info(rows.to_s)
      value = rows["value"];
    elsif sql.adapter_name == "SQLite"
      rows = sql.select_one("select strftime('%Y.%m.%d',date('now')) as value;");
      value = rows["value"];
    else
      value = Time.now;
    end

    value;
  end

  #execute - executes SQL query. For "SELECT ..." query will return Mysql::Result class (or other result-set class for your Ruby database interface).
  #insert - executes SQL query and returns last inserted id
  #update, delete - executes SQL query and returns number of affected rows
  #begin_db_transaction - executes SQL query 'BEGIN' (transaction start)
  #commit_db_transaction - executes SQL query 'COMMIT' (confirm transaction)
  #rollback_db_transaction - executes SQL query 'ROLLBACK' (rollback transaction)

  def self.get_database_time
    sql = ActiveRecord::Base.connection();
    #Rails.logger.info(sql.adapter_name)
    if sql.adapter_name == "MsSQL"
      #sql.execute "SET autocommit=0";
      #sql.begin_db_transaction
      rows = sql.select_one("Select CONVERT(varchar(100), GETDATE(), 20) as value");
      #sql.commit_db_transaction
      #Rails.logger.info(rows.to_s)
      value = rows["value"];
    elsif sql.adapter_name == "SQLite"
      rows = sql.select_one("select strftime('%Y.%m.%d %H:%M%S',date('now')) as value;");
      value = rows["value"];
    else
      value = Time.now;
    end

    value;
  end

  private

  def self.reload_java_configuration
    #Java::OrgSonarServerUi::JRubyFacade.new.reloadConfiguration()
  end
end
