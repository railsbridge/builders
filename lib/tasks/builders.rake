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

    desc 'add volunteers to projects'
    task :project_volunteers => :environment do
      ProjectVolunteer.delete_all

      min = User.first.id
      max = User.last.id

      Project.all.each do |project|
        number_of_volunteers = Forgery(:basic).number(:at_least => 0, :at_most => 10)

        (0..number_of_volunteers).each do |v|
          user_id = Forgery(:basic).number(:at_least => min, :at_most => max)
          
          unless ProjectVolunteer.exists?(:project_id => project.id, :user_id => user_id)
            pv = ProjectVolunteer.new(:project => project, :user => User.find(user_id))
            pv.role = 'volunteer'
            pv.save
          end
        end
      end
    end
  end
  
  desc 'seed Builders data'
  task :seed => ['builders:seed:volunteers', 'builders:seed:projects', 'builders:seed:project_volunteers']
end
