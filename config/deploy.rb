# config valid only for current version of Capistrano
lock '3.5.0'
set :rails_env, 'development'
set :application, 'cgms'
set :user, "root"


# Default value for :scm is :git
set :scm, :git
set :repo_url, 'git@github.com:ankon8050/garmentserp_one.git'
set :branch, 'master'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/root/app/isa"

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
#set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
#set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :linked_dirs, fetch(:linked_dirs, []).push('log')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :bundle_without, %w{test}.join(' ')

# Default value for keep_releases is 5
set :keep_releases, 3

set :passenger_restart_with_touch, true

#set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:rails_env)}" }

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute "sudo chmod 777 -R /root/app/isa/"
          # If 403 forbidden error occured
          #execute "sudo chown -R root:root /home/root/apps/cgms"
        end
      end
    end
  end

end