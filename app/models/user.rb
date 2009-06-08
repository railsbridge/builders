class User < ActiveRecord::Base
  acts_as_authentic
  
  validates_presence_of :name
  
  is_taggable :skills
  
  attr_protected :admin

  def deliver_password_reset_instructions
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
end
