require 'pp'
class MainController < ApplicationController
  def index
  end

  def refine
    @query = params['q']
    @results = Zeke.search(@query).toponyms.collect do |place|
      puts place.population if place.population and place.population > 0
      puts place.admin_code_1 if place.admin_code_1
      puts place.admin_code_2 if place.admin_code_2
      {
        :id => "place",
        :name => place.name,
        :alternate_names => (place.alternate_names ? place.alternate_names : ""),
        :value => "#{place.latitude}, #{place.longitude}",
        :coordinates => "#{place.latitude}, #{place.longitude}"
      }
    end
  end

  def results
    @radius = params['r']
    @id = params['id']
    # @units = params['units'] todo this should accept kilometers or miles in the future.
    lat = @id.split[0][0..-2].to_i # these will return 0 if these are non-string values.  might wanna display a warning in that case?
    lng = @id.split[1][0..-2].to_i
    @results = Zeke.cities_in_radius(@radius, lat, lng).sort_by {|city| city["population"].to_i}.reverse
  end
end
