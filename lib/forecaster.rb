require 'pry'
require "./lib/zipcode_service.rb"

class Forecaster
  attr_reader :zipcode, :granularity, :output, :coordinates
  def initialize(args)
    @zipcode = args[0] || nil
    @granularity = args[1] || nil
    @output = args[2] || nil
  end

  def get_coordinates
    zcs = ZipcodeService.new(zipcode)
    @coordinates ||= zcs.get_lat_lng
  end

  
end

######
forecast = Forecaster.new(ARGV)
forecast.get_coordinates
puts forecast.coordinates

