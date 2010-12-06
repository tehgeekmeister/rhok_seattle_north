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
  
  def self.cities_in_radius(distance, lat, lng, units = :kilometers)
    conn = ActiveRecord::Base.connection
    coords = Geokit::LatLng.new(lat,lng)
    raise ArgumentError unless (units == :miles) or (units == :kilometers)
    distance = distance * 0.621371192 if units == :miles
    box = Geokit::Bounds.from_point_and_radius coords, distance
    sw, ne = box.sw, box.ne
    nw, se = Geokit::LatLng.new(sw.lat, ne.lng), Geokit::LatLng.new(ne.lat, sw.lng)
    conn.select_all("select * from cities where Contains(GeomFromText('Polygon((#{sw.lat} #{sw.lng}, #{nw.lat} #{nw.lng}, #{ne.lat} #{ne.lng}, #{se.lat} #{se.lng}, #{sw.lat} #{sw.lng}))'), location);")
  end
  
end
