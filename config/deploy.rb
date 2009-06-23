set :application, "builders"
set :repository,  "git://github.com/railsbridge/builders.git"
set :user, "rbadmin"
set :deploy_via, :fast_remote_cache
set :copy_exclude, %w(test .git doc)
set :scm, :git

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/Library/Rails/#{application}"

role :web, "72.249.191.152"
role :app, "72.249.191.152"
role :db,  "72.249.191.152", :primary => true

set :keep_releases, 4

namespace :deploy do
  desc "Default deploy - updated to run migrations"
  task :default do
    set :migrate_target, :latest
    update_code
    symlink
    link_files
    migrate
    restart
  end
  
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Re-link files"
  task :link_files, :roles => :app do
    ['config/initializers/smtp_gmail.rb', 'db/production.sqlite3'].each do |file|
      run "ln -nsf #{shared_path}/#{file} #{current_path}/#{file}"
    end
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end
