namespace :builders do  
  namespace :seed do
    
    desc 'seed the admin account'
    task :admin => :environment do
      User.delete_all({:admin => true})

      the_admin = User.new(:email => 'builders@railsbridge.org', 
                           :password => 'd0goodTh1ngs',
                           :password_confirmation => 'd0goodTh1ngs',
                           :name => 'Builder Admin')
               
      the_admin.admin = true
      the_admin.save!      
    end

    desc 'seed 25 volunteers'
    task :volunteers => :environment do
      User.delete_all({:admin => false})

      25.times do
        pw = Forgery(:basic).password
        User.create(:name                 => Forgery(:name).full_name,
                    :email                => Forgery(:internet).email_address,
                    :hours_per_week       => Forgery(:basic).number(:at_least => 0),
                    :availability_starts  => Date.today - Forgery(:basic).number.weeks,
                    :availability_ends    => Date.today + Forgery(:basic).number.months,
                    :notes                => Forgery(:lorem_ipsum).paragraph,
                    :password             => pw,
                    :password_confirmation => pw) 
      end
    end
  end
  
  desc 'seed Builders data'
  task :seed => ['builders:seed:admin', 'builders:seed:volunteers']  
end
