require 'digest/md5'

class Project < ActiveRecord::Base
  before_create :generate_access_key
  
  has_many :project_volunteers
  has_many :volunteers, :through => :project_volunteers, :source => :user, :class_name => 'User'

  validates_presence_of [:contact_email, :contact_name, :org_name]

  attr_protected :access_key

  private

  def generate_access_key
    write_attribute(:access_key, Digest::MD5.hexdigest((object_id + rand(255)).to_s))
  end
end
