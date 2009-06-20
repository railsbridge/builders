class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :project_volunteers
  has_many :projects, :through => :project_volunteers

  validates_presence_of :name
  
  is_taggable :skills
  
  attr_protected :admin

  include TrixyScopes

  def deliver_password_reset_instructions
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
end
