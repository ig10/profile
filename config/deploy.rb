# config valid only for Capistrano 3.1
require "bundler/capistrano"
lock '3.2.1'

set :application, 'profile'
set :repo_url, 'git@github.com:ig10/profile.git'
set :deploy_to, '/mnt/profile'
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{release_path} && touch ./tmp/restart.txt"
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
