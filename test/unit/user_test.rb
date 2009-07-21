require File.join(File.dirname(__FILE__), '..', 'test_helper')
 
class UserTest < ActiveSupport::TestCase
  
  should_have_db_column :email, :type => "string"    
  should_have_db_column :crypted_password, :type => "string"    
  should_have_db_column :password_salt, :type => "string"    
  should_have_db_column :persistence_token, :type => "string"
  should_have_db_column :name, :type => "string"    
  should_have_db_column :availability_starts, :type => "date"    
  should_have_db_column :availability_ends, :type => "date"    
  should_have_db_column :hours_per_week, :type => "integer"    
  should_have_db_column :notes, :type => "text"
  should_have_db_column :single_access_token, :type => "string"
  should_have_db_column :perishable_token, :type => "string"
  should_have_db_column :admin, :type => "boolean"
  should_have_db_column :receive_notifications, :type => "boolean"
  should_have_db_column :aliases, :type => "string"
    
  should_be_authentic
  
  should_validate_presence_of :name
  
  should_be_taggable :skills 
  
  should_not_allow_mass_assignment_of :admin
  
  should_have_many :project_volunteers
  should_have_many :projects, :through => :project_volunteers

  context '#deliver_password_reset_instructions' do
    setup do 
      @user = Factory(:user)
      stub(Notifier, :method_missing)
      stub(Notifier, :deliver_password_reset_instructions).with(@user)
    end
    
    should 'change #perishable_token' do
      old_token = @user.perishable_token
      @user.deliver_password_reset_instructions
      assert_not_equal old_token, @user.perishable_token
    end

    should 'send email' do
      @user.deliver_password_reset_instructions
      assert_received(Notifier) { |notifier| notifier.deliver_password_reset_instructions(@user) }
    end
  end
end
