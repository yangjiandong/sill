
require 'fastercsv'
class SystemController < ApplicationController

  SECTION=Navigation::SECTION_CONFIGURATION
  #before_filter :admin_required

  def index
    @server=Server.new()

    respond_to do |format|
      format.html
      format.csv  {
        send_data(to_csv, :type => 'text/csv; charset=utf-8', :disposition => 'attachment; filename=sonar_system_info.csv')
      }
    end
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
