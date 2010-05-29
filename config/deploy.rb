set :application, "ppe"
set :user, "ubuntu"
set :runner, "ubuntu"
set :domain, "stage.vizzuality.com"

default_run_options[:pty] = true
set :scm, :git
set :repository,  "http://github.com/tokumine/pa-explore.git"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "stage.vizzuality.com"                          # Your HTTP server, Apache/etc
role :app, "stage.vizzuality.com"                          # This may be the same as your `Web` server
role :db,  "stage.vizzuality.com", :primary => true # This is where Rails migrations will run

set :app_path, "/home/ubuntu/www/#{application}"
set :deploy_to, app_path

namespace :deploy do
  task :start do end
  task :stop do end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end