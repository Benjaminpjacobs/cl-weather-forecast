require 'net/http'
require 'json'
require 'yaml'

class ZipcodeService
  attr_reader :key, :zipcode
  
  def initialize(zipcode)
    @zipcode = zipcode
    @key = YAML::load(File.read('.config.yml'))['ZIPCODE_API']
  end

  def get_lat_lng
    response  = Net::HTTP.get(URI "https://www.zipcodeapi.com/rest/#{key}/info.json/#{zipcode}/radians")
    parsed    = JSON.parse(response, symbolize_names: true)
    
    unless parsed[:error_code]
      {lat: parsed[:lat], lng: parsed[:lng]}
    end
  end
end