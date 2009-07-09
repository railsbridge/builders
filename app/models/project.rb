require 'digest/md5'

class Project < ActiveRecord::Base
  include TrixyScopes
  
  before_create :generate_access_key
  
  has_many :project_volunteers
  has_many :volunteers, :through => :project_volunteers, :source => :user, :class_name => 'User'

  validates_presence_of [:contact_email, :contact_name, :org_name]

  attr_protected :access_key, :status

  def team_member?(user)
    volunteers.include?(user)
  end

  def authorized?(key)
    if key.is_a?(User)
      key.admin? || team_member?(key)
    else
      self.access_key == key
    end
  end

  state_machine :status, :initial => :unapproved do
    other_states :active, :complete, :cancelled

    event :approve do
      transition [:unapproved, :cancelled] => :active
    end

    event :cancel do
      transition :active => :cancelled
    end

    event :mark_completed do
      transition :active => :complete
    end
  end

  private

  def generate_access_key
    write_attribute(:access_key, Digest::MD5.hexdigest((object_id + rand(255)).to_s))
  end
end
