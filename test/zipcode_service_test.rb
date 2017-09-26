gem 'minitest'
require 'pry'
require 'minitest/autorun'
require_relative '../lib/zipcode_service.rb'

class ZipcodeserviceTest < Minitest::Test
  def test_it_exists
    zs = ZipcodeService.new('80210')
    assert_instance_of ZipcodeService, zs
  end

  def test_it_returns_coordinates
    zs = ZipcodeService.new('80210')
    result = zs.get_lat_lng    
    
    assert_instance_of Hash, result
    refute_nil result[:lat]
    refute_nil result[:lng]
  end

  def test_it_returns_nil_with_bad_zip
    zs = ZipcodeService.new('8021')
    result = zs.get_lat_lng
    assert_nil result
  end
end
