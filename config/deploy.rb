# config valid only for Capistrano 3.1
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

  desc "Symlinks the database.yml"
  task :symlink_db, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  after 'deploy:update_code', 'deploy:symlink_db'
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
