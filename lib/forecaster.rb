require 'pry'
require "./lib/zipcode_service.rb"
require "./lib/darksky_service.rb"
# require "./lib/weather_formatter.rb"

class Forecaster
  attr_reader :zipcode, :granularity, :output
  def initialize(args)
    @zipcode = args[0] || nil
    @granularity = args[1] || nil
    @output = args[2] || nil
  end

  def retrieve_coordinates
    zcs = ZipcodeService.new(zipcode)
    zcs.get_lat_lng
  end

  def retrieve_forecast
    coordinates = retrieve_coordinates
    dss = DarkskyService.new(coordinates)
    dss.get_forecast
  end

  def print_weather
    forecast = retrieve_forecast
    formatter = WeatherFormatter.new(granularity, forecast)
    formatted = formatter.format_weather
    puts formatted
  end
  
end

######
forecast = Forecaster.new(ARGV)
forecast.print_weather


