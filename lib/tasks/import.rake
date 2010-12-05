namespace :import do
  desc "imports cities data from geonames file."
  task :import => :environment do
    `unzip #{File.join(Rails.root, "data/cities1000.zip")} -d #{File.join(Rails.root, "data")}`
    Zeke.import
  end
  
  desc "downloads cities1000.zip from geonames."
  task :download do
    `wget 'http://download.geonames.org/export/dump/cities1000.zip' -O #{File.join(Rails.root, "data/cities1000.zip")}`
  end
  
  desc "downloads and imports"
  task :all => [:download, :import]
end