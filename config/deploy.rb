set :application, 'helio'
set :repo_url, 'https://github.com/GSA-OCSIT/helio.git'

set :default_stage, 'qa'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/var/www/helio'
set :current_path, "#{deploy_to}/current"
set :shared_path, "#{deploy_to}/shared"

set :scm, :git
set :use_sudo, :false
set :format, :pretty
set :log_level, :debug
set :pty, true
set :ssh_options, { :forward_agent => true }

# deploy a branch...
set :branch, :resque_deployment

set :resque_environment_task, true

set :linked_files, %w{config/database.yml config/application.yml config/redis/production.conf}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :mkdir, current_path.join('tmp')
      execute :touch, current_path.join('tmp/restart.txt')
      # run "touch #{current_release}/tmp/restart.txt"
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
  after :finishing, 'deploy:migrate'
  after 'deploy:restart', 'resque:restart'
end