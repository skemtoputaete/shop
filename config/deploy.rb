# config valid only for current version of Capistrano
lock "3.8.2"

set :application, "shop"
set :repo_url, "git@github.com:skemtoputaete/shop.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deployer/projects/shop"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :puma do
  desc 'Restart the Puma Background Worker'
  task :restart_puma do
    on roles(:app) do
      execute "sudo restart shop"
    end
  end

  after 'deploy:finishing', 'puma:restart_puma'
end

namespace :thinkingsphinx do
  desc 'Restart the sphinxsearch'
  task :restart_ts do
    on roles(:app) do
      execute "cd /home/deployer/projects/shop/current"
      execute "RAILS_ENV=production bundle exec rake ts:stop ts:clear ts:configure ts:index ts:start"
    end
  end

  after 'deploy:finishing', 'thinkingsphinx:restart_ts'
end
