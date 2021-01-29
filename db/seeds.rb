require("#{Rails.root}/lib/tasks/Crawler/Dcard/dcard_process_files.rb")
require("#{Rails.root}/lib/tasks/Crawler/PTT/ptt_process_files.rb")

Source.create(name: "Dcard")
Source.create(name: "PTT")

dcard_update_boards()
dcard_csv_to_psql()
ptt_boards()
ptt_csv_to_psql()
