gem 'minitest'
require 'pry'
require 'minitest/autorun'
require 'webmock/rspec'
require_relative '../lib/darksky_service.rb'

WebMock.disable_net_connect!(allow_localhost: true)

class DarkskyServiceTest < Minitest::Test
  def test_it_exists
    dss = DarkskyService.new({lat: 0.692488, lng:-1.83194})
    assert_instance_of DarkskyService, dss
  end

  def test_it_returns_weather_object
    WebMock.stub_request(:get, "https://api.darksky.net/forecast/640644acf3d2e971e41cef9646c4f0aa/0.692488,-1.83194")
    .with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.darksky.net', 'User-Agent'=>'Ruby'})
    .to_return(status: 200, body: "{\"latitude\": \"\", \"longitude\": \"\", \"timezone\": \"\", \"currently\": \"\", \"hourly\":\"\", \"daily\":\"\" }", headers: {})
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
    WebMock.stub_request(:get, "https://api.darksky.net/forecast/640644acf3d2e971e41cef9646c4f0aa/,").
    with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.darksky.net', 'User-Agent'=>'Ruby'}).
    to_return(status: 200, body: "{\"error\":\" \"}", headers: {})

    dss = DarkskyService.new({})
    result = dss.get_forecast
    assert_nil result
  end
end
