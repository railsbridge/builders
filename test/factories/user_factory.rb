Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |factory|
  factory.email { Factory.next :email }
  factory.password "secret"
  factory.password_confirmation "secret" 
  factory.name 'Mother Theresa'
  factory.availability_starts '2009-05-07'
  factory.availability_ends '2009-05-07'
  factory.hours_per_week '1'
  factory.notes 'MyText'
end
