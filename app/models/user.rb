class User < ActiveRecord::Base
  include TrixyScopes
  SORTABLE_COLUMNS = ["updated_at", "availability_starts"]

  acts_as_authentic
  is_taggable :skills
  is_gravtastic

  has_many :project_volunteers
  has_many :projects, :through => :project_volunteers

  validates_presence_of :name
    
  attr_protected :admin

  def deliver_password_reset_instructions
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
end
