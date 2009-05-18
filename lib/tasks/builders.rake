namespace :builders do  
  namespace :seed do
    
    desc 'seed the admin account'
    task :admin => :environment do
      the_admin = User.new(:email => 'builders@railsbridge.org', 
                           :password => 'd0goodTh1ngs',
                           :password_confirmation => 'd0goodTh1ngs',
                           :name => 'Builder Admin')
               
      the_admin.admin = true
      the_admin.save!      
    end       
  end
  
  desc 'seed Builders data'
  task :seed => ['builders:seed:admin']  
end