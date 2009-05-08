class User < ActiveRecord::Base
  acts_as_authentic
  
  validates_presence_of :name
  
  is_taggable :skills
end