Factory.define :project do |factory|
  factory.org_name "Christian Children's Fund"
  factory.org_details "An international child sponsorship group based in Richmond, Virginia, United States, that provides assistance to communities in many developing countries, as well as in the United States."
  factory.contact_name 'Sally Struthers'
  factory.contact_phone ''
  factory.contact_email 'sally@christianchildrensfund.org'
  factory.website 'www.christianchildrensfund.org'
  factory.description 'We could really use a forum for our web site.'
  factory.approved 'false'
  factory.notes 'please help the children. "Sally\'s Home Page":http://sallystruthers.com'
end

Factory.define :active_project, :parent => :project do |factory|
  factory.status "active"
  factory.approved true
end
