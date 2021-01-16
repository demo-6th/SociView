require("#{Rails.root}/lib/tasks/Crawler/Dcard/process_files.rb")

Source.create(name: "Dcard")
Source.create(name: "PTT")
Source.create(name: "Eney")

# update_testboards()
# testcsv_to_psql()
