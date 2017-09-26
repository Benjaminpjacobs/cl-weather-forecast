require 'net/http'
require 'json'

class DarkskyService
  attr_reader :coordinates, :key

  def initialize(coordinates)
    @coordinates = coordinates
    @key = @key = YAML::load(File.read('.config.yml'))['DARKSKY_API']
  end

  def get_forecast
    response  = Net::HTTP.get(URI "https://api.darksky.net/forecast/#{key}/#{coordinates[:lat]},#{coordinates[:lng]}")  
    parsed    = JSON.parse(response)
    unless parsed["error"]
      parsed
    end
  end
end