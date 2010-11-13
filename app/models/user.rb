require 'digest/sha1'

class User < ActiveRecord::Base
  set_table_name 't_users'

  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  # include NeedAuthorization::ForUser
  # include NeedAuthentication::ForUser

  validates_length_of :name, :maximum => 100, :allow_blank => true, :allow_nil => true

  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login, :case_sensitive => true
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message


  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation

  def name(login_if_nil=false)
    result=read_attribute :name
    result.blank? ? login : result
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def <=>(other)
    login<=>other.login
  end

  #---------------------------------------------------------------------
  # USER PROPERTIES
  #---------------------------------------------------------------------
  def property(key)
    properties().each do |p|
      return p if (p.key==key)
    end
    nil
  end

  def property_value(key)
    prop=property(key)
    prop ? prop.value : nil
  end

  def set_property(options)
    key=options[:prop_key]
    prop=property(key)
    if prop
      prop.attributes=options
      prop.user_id=id
      prop.save!
    else
      prop=Property.new(options)
      prop.user_id=id
      properties<<prop
    end
  end

  def delete_property(key)
    prop=property(key)
    if prop
      properties.delete(prop)
    end
  end
  
end
