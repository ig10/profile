# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'profile'
set :repo_url, 'git@github.com:ig10/profile.git'
set :deploy_to, '/mnt/profile'
set :keep_releases, 5

namespace :deploy do

  desc 'Bundle Install'
  task :bundle do
    on roles(:app) do
      execute "cd #{release_path} && bundle install"
    end
  end

  desc 'DB Migrate'
  task :bundle do
    on roles(:app) do
      execute "cd #{release_path} && bundle exec rake db:migrate"
    end
  end

  desc 'Assets Precompile'
  task :precompile do
    on roles(:app) do
      execute "cd #{release_path} && rake assets:precompile"
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{release_path} && touch ./tmp/restart.txt"
    end
  end

  before :publishing, :bundle
  before :publishing, :precompile
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
