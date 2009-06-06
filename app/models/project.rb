require "MD5"

class Project < ActiveRecord::Base
  before_create :generate_access_key

  validates_presence_of [:contact_email, :contact_name, :org_name]

  attr_protected :access_key

  private

  def generate_access_key
    write_attribute(:access_key, MD5.hexdigest((object_id + rand(255)).to_s))
  end
end
