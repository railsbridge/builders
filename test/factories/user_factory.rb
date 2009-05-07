Factory.define :user do |factory|
  factory.email 'MyString'
  factory.crypted_password 'MyString'
  factory.password_salt 'MyString'
  factory.persistance_token 'MyString'
  factory.first_name 'MyString'
  factory.availability_starts '2009-05-07'
  factory.availability_ends '2009-05-07'
  factory.hours_per_week '1'
  factory.notes 'MyText'
end