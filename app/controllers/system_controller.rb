
require 'fastercsv'
class SystemController < ApplicationController
#  caches_page :index

  skip_before_filter :check_authentication

  SECTION=Navigation::SECTION_CONFIGURATION

  def index
    @server=Server.new()

    @login_cache_value = Rails.cache.read("last_login")
#     data_cache('app_login_info'){'新建值'}

    respond_to do |format|
      format.html
      format.csv  {
        send_data(to_csv, :type => 'text/csv; charset=utf-8', :disposition => 'attachment; filename=sill_system_info.csv')
      }
    end
  end

  def sysConfig
    data = {
        :time => Property.get_database_time(),
        :version => "1.0",
        :buildId => "xxxx",
        :copyright => "一定要同步啊?",
        :productName => "ror - 应用程序"
        };

    render :json => {
       :success => true,
      :data => data}, :layout => false
  end

  def welcome
    render :layout => false
  end

  def get_data_sql
    all=[]
    sql = "select * from t_users"
    results = User.connection.execute(sql)
    results.each do |foo|
      all.push "(#{foo['login']}, #{foo['name']})"
    end

    render :json => {
        :rows => all,
        :results => all.count
        }, :layout => false
  
  end

  private

  def to_csv
    FasterCSV.generate do |csv|
      @server.info.each do |property|
        csv << property
      end
    end
  end
end
