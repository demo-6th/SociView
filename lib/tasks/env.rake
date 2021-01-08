namespace :Env do 
  desc "Install python packages"
  task :pyenv => :environment do 
    `python3 lib/tasks/Py/settings.py`
  end 
end 