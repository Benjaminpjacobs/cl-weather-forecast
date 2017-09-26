gem 'minitest'
require 'pry'
require 'minitest/autorun'
require 'webmock/rspec'
require_relative '../lib/zipcode_service.rb'

WebMock.disable_net_connect!(allow_localhost: true)

class ZipcodeserviceTest < Minitest::Test
  def test_it_exists
    zs = ZipcodeService.new('80210')
    assert_instance_of ZipcodeService, zs
  end

  def test_it_returns_coordinates
    WebMock.stub_request(:get, "https://www.zipcodeapi.com/rest/yruKeJMZU3uXpx42ZmxaLpiCyjzgmF5V6zFkiskdvPaVmfXlCvwoUP0s8AJvgOqn/info.json/80210/degrees")
    .with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'www.zipcodeapi.com', 'User-Agent'=>'Ruby'})
    .to_return(status: 200, body: "{\"lat\":\"\",\"lng\":\"\"}", headers: {})

    zs = ZipcodeService.new('80210')
    result = zs.get_lat_lng    
    
    assert_instance_of Hash, result
    refute_nil result[:lat]
    refute_nil result[:lng]
  end

  def test_it_returns_nil_with_bad_zip
    WebMock.stub_request(:get, "https://www.zipcodeapi.com/rest/yruKeJMZU3uXpx42ZmxaLpiCyjzgmF5V6zFkiskdvPaVmfXlCvwoUP0s8AJvgOqn/info.json/8021/degrees")
    .with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'www.zipcodeapi.com', 'User-Agent'=>'Ruby'})
    .to_return(status: 200, body: "{\"error_code\": \"\"}", headers: {})
    
    zs = ZipcodeService.new('8021')
    result = zs.get_lat_lng
    assert_nil result
  end
end
