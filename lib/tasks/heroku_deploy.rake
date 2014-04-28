namespace :heroku do
  
  desc "deploy app to heroku"
  task :deploy do
    app = 'nytech'
    remote = "git@heroku.com:#{app}.git"
    
    system "heroku maintenance:on --app #{app}"
    system "git push #{remote} master"
    system "heroku run rake db:migrate --app #{app}"
    system "heroku maintenance:off --app #{app}"
  end
  
end