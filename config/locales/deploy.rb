# config valid only for Capistrano 3.1
require 'capistrano/setup'
require 'capistrano/deploy'
require "capistrano/bundler"
require 'capistrano/rails'
require "capistrano/rvm"

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
require "capistrano/puma"

set :rails_env, 'production'
set :user, 'root'
set :use_sudo, true

set :application, 'garmentserp_one'
set :repo_url, 'git@github.com:rakib063049/LifeBoySchool.git'
set :branch, :capistrano

set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"

set :scm, :git
set :pty, true

# Default value for default_env is {}
set :default_env, {path: "/usr/local/bin:$PATH"}

set :keep_releases, 3
set :default_shell, '/bin/bash -l'

set :rbenv_ruby, '2.1.2p95'
set :bundle_bins, %w("bundle exec")
set :rvm_map_bins, %w{gem rake ruby bundle}
set :bundle_roles, :app
set :migration_role, :db
set :assets_roles, %w{app}

set :log_level, :debug

namespace :deploy do
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  #after :finishing, :compile_assets
  #after :finishing, :cleanup
  #after :finishing, :restart
end