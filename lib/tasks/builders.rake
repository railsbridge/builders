namespace :builders do  
  namespace :seed do
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
  task :seed => ['builders:seed:volunteers']  
end
