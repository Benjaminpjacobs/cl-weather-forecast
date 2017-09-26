require 'net/http'
require 'json'

class ZipcodeService
  attr_reader :key, :zipcode
  
  def initialize(zipcode)
    @zipcode = zipcode
    @key = 'yruKeJMZU3uXpx42ZmxaLpiCyjzgmF5V6zFkiskdvPaVmfXlCvwoUP0s8AJvgOqn'
  end

  def get_lat_lng
    response  = Net::HTTP.get(URI "https://www.zipcodeapi.com/rest/#{key}/info.json/#{zipcode}/radians")
    parsed    = JSON.parse(response, symbolize_names: true)
    
    unless parsed[:error_code]
      {lat: parsed[:lat], lng: parsed[:lng]}
    end
  end
end