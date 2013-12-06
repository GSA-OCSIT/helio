set :application, 'helio'
set :domain,      "github.com"
# set :repo_url, 'https://github.com//helio.git'
set :repository,  "ssh://#{domain}/GSA-OCSIT/#{application}.git"

set :default_stage, 'qa'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, "/var/www/#{application}"
set :current_path, "#{deploy_to}/current"
set :shared_path, "#{deploy_to}/shared"

set :scm, :git
set :use_sudo, :false
set :format, :pretty
set :log_level, :debug
set :pty, true
set :ssh_options, { :forward_agent => true }

set :linked_files, %w{config/database.yml config/application.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
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
