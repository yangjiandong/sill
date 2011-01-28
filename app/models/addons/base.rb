#use other database connection
class Addons::Base < ActiveRecord::Base
  # No corresponding table in the DB.
  self.abstract_class = true

  # Open a connection to the appropriate database depending
  # on what RAILS_ENV is set to.
  #establish_connection("account_#{RAILS_ENV}")
  establish_connection("other")
end
