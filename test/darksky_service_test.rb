gem 'minitest'
require 'pry'
require 'minitest/autorun'
require_relative '../lib/darksky_service.rb'

class DarkskyServiceTest < Minitest::Test
  def test_it_exists
    dss = DarkskyService.new({lat: 0.692488, lng:-1.83194})
    assert_instance_of DarkskyService, dss
  end

  def test_it_returns_weather_object
    dss = DarkskyService.new({lat: 0.692488, lng:-1.83194})
    result = dss.get_forecast   

    assert_instance_of Hash, result
    refute_nil result['latitude']
    refute_nil result['longitude']
    refute_nil result['timezone']
    refute_nil result['currently']
    refute_nil result['hourly']
    refute_nil result['daily']
  end

  def test_it_returns_nil_with_bad_zip
    dss = DarkskyService.new({})
    result = dss.get_forecast
    assert_nil result
  end
end
