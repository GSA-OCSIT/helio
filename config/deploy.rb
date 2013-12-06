set :application, 'helio'
set :repo_url, 'git@example.com:GSA-OCSIT/helio.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/var/www/helio'
set :shared_path, "#{deploy_to}/shared"

set :scm, :git

set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_files, %w{config/database.yml config/application.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end




require 'bundler/capistrano'
require 'capistrano/ext/multistage'
require './config/boot'
require 'airbrake/capistrano'

set :stages, %w(staging staging-cgi production-cgi)
set :default_stage, "staging"

set :use_sudo, false
set :application, "mygov-account"
set :scm, "git"
set :repository, "https://github.com/GSA-OCSIT/mygov-account.git"
set :deploy_via, :remote_cache
set :branch, ENV['BRANCH'] || 'master'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Symlinks the initializers and other config files"
  task :symlink_config, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/environments/production.rb #{release_path}/config/environments/production.rb"
    run "ln -nfs #{deploy_to}/shared/config/initializers/01_mygov.rb #{release_path}/config/initializers/01_mygov.rb"
    run "ln -nfs #{deploy_to}/shared/config/initializers/airbrake.rb #{release_path}/config/initializers/airbrake.rb"
    run "ln -nfs #{deploy_to}/shared/config/initializers/recaptcha.rb #{release_path}/config/initializers/recaptcha.rb"
    run "ln -nfs #{deploy_to}/shared/config/resque.yml #{release_path}/config/resque.yml"
  end

  desc "Restart Resque Workers"
  task :restart_workers, :roles => :worker do
    run_remote_rake "resque:restart_workers"
  end
end

# set :branch, "resque_and_devise"
# set :scm, :none
# set :repository, "."
# set :deploy_via, :copy


before 'deploy:assets:precompile', 'deploy:symlink_db'
before 'deploy:assets:precompile', 'deploy:symlink_config'
after "deploy:restart", "resque:restart"
after "deploy:restart", "deploy:cleanup"