require "./lib/zipcode_service.rb"
require "./lib/darksky_service.rb"
require "./lib/weather_formatter.rb"

class Forecaster
  attr_reader :zipcode, :granularity, :output
  
  def initialize(args)
    @zipcode = args[0]
    @granularity = args[1]
    @output = args[2]
  end
  
  def print_weather
    coordinates = retrieve_coordinates
    return puts "There was a network problem trying to reach The Zipcode Api" unless coordinates
    
    forecast    = retrieve_forecast(coordinates)
    return puts "There was a network problem trying to reach The DarkSky API" unless forecast
    formatted   = format_weather(forecast)
    
    puts output ? write_file(formatted) : formatted
  end
  
  private

    def format_weather(forecast)
      formatter   = WeatherFormatter.new(granularity, forecast)
      formatter.format_weather
    end

    def retrieve_coordinates
      zcs = ZipcodeService.new(zipcode)
      zcs.get_lat_lng
    end

    def retrieve_forecast(coordinates)
      dss = DarkskyService.new(coordinates)
      dss.get_forecast
    end
  
    def write_file(formatted)
      file = File.open(output, 'a')
      file.write(formatted)
      file.close
      "Results written to #{output}"
    end
end

######
forecast = Forecaster.new(ARGV)
forecast.print_weather


