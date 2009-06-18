Factory.define :project_volunteer do |factory|
  factory.association :user
  factory.association :project
  factory.role 'MyString'
end
