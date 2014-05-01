namespace :heroku do
  
  desc "deploy app to heroku"
  task :deploy do
    app = 'wolfpackbeta'
    remote = "git@heroku.com:#{app}.git"
    
    system "RAILS_ENV=production bundle exec rake assets:precompile"
    system "git add public/assets"
    system 'git commit -m "vendor compiled assets"'
    system "heroku maintenance:on --app #{app}"
    system "git push #{remote} master"
    system "heroku run rake db:migrate --app #{app}"
    system "heroku maintenance:off --app #{app}"
  end
  
end