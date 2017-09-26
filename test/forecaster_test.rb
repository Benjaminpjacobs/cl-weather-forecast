gem 'minitest'
require 'pry'
require 'minitest/autorun'
require_relative '../lib/forecaster.rb'

class ForecasterTest < Minitest::Test
  def test_it_exists_and_has_variables
    forecaster = Forecaster.new(['80210', 'currently', 'temp_file.txt'])
  
    assert_instance_of Forecaster, forecaster
    assert_equal forecaster.zipcode, '80210'
    assert_equal forecaster.granularity, 'currently'
    assert_equal forecaster.output, 'temp_file.txt'
  end

  def test_it_writes_a_file_with_weather_information
    forecaster = Forecaster.new(['80210', 'currently', 'temp_file.txt'])
    forecaster.print_weather
    result = File.readlines('temp_file.txt')
    File.delete('temp_file.txt')
    
    assert_equal result.length, 18
    assert_equal result.first[0..4], 'Time:'
    assert_equal result.last[0..5], 'Ozone:'
    
  end
end
