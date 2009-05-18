class Project < ActiveRecord::Base
  validates_presence_of [:contact_email, :contact_name, :org_name]
end