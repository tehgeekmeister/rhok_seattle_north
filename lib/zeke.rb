require 'progressbar'
require 'geonames'
# require 'geokit'

class Zeke
  
  def self.import
    conn = ActiveRecord::Base.connection
    File.open(File.join(Rails.root, "data/cities1000.txt")) do |f|
      pb = ProgressBar.new("insert!", `wc -l 'data/cities1000.txt'`.to_i)
      f.lines.each do |line|
        line = line.split("\t")
        name = line[1]
        alternate_names = line[3]
        lat = line[4]
        lng = line[5]
        population = line[14]
        country_code = line[8]
        conn.execute "insert into cities values ('#{conn.quote_string name}', '#{country_code}', '#{conn.quote_string alternate_names}', POINT(#{lat}, #{lng}), #{population});"
        pb.inc
      end
      pb.finish
    end
  end
  
  def self.search(q)
    sc = Geonames::ToponymSearchCriteria.new
    sc.q = q
    Geonames::WebService.search sc
  end
  
  # def self.wikipedia_places_in_radius(distance, lat, lng, units = :kilometers)
  #   # coords = Geokit::LatLng.new(lat,lng)
  #   raise ArgumentError unless (units == :miles) or (units == :kilometers)
  #   distance = distance * 0.621371192 if units == :miles
  #   # box = Geokit::Bounds.from_point_and_radius coords, distance
  #   # sw, ne = box.sw, box.ne
  #   return Geonames::WebService.find_nearby_wikipedia({:lat => lat, :long => lng, :radius => distance, :max_rows => 10000}).select {|r| r.population.to_i > 0}
  # end
  
end
