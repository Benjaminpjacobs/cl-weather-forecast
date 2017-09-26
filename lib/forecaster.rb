require 'pry'

class Forecaster
  attr_reader :zipcode, :granularity, :output
  def initialize(args)
    @zipcode = args[0]
    @granularity = args[1]
    @output = args[2] || nil
  end

  def print
    binding.pry
  end
end

######
forecast = Forecaster.new(ARGV)
forecast.print
