require File.expand_path('../config/environment', __dir__)
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
# Learn more: http://github.com/javan/whenever

#step1設定排程檔(下方) 格式參照GH https://github.com/javan/whenever
#step2寫入排程:whenever --update-crontab
#step3啟動計時器:sudo cron start/
#step4關閉計時器:sudo service cron stop
 


set :output, { error: 'log/cron_error.log' }
  every 1.day, at: '3:50 am' do
      rake "Crawler:run_dcard"
  end