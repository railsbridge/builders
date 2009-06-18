namespace :builders do  
  namespace :seed do
    desc 'seed 25 volunteers'
    task :volunteers => :environment do
      User.delete_all({:admin => false})

      25.times do
        pw = 'secret'
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

    desc 'seed 5 projects'
    task :projects => :environment do
      Project.delete_all

      5.times do
        Project.create(:org_name      => Forgery(:name).company_name,
                       :org_details   => Forgery(:lorem_ipsum).paragraph,
                       :contact_name  => Forgery(:name).full_name,
                       :contact_email => Forgery(:internet).email_address,
                       :description   => Forgery(:lorem_ipsum).paragraph)
      end
    end
  end
  
  desc 'seed Builders data'
  task :seed => ['builders:seed:volunteers', 'builders:seed:projects']  
end
