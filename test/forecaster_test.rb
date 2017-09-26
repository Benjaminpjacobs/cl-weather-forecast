gem 'minitest'
require 'pry'
require 'minitest/autorun'
require 'webmock/rspec'

WebMock.stub_request(:get, "https://www.zipcodeapi.com/rest/yruKeJMZU3uXpx42ZmxaLpiCyjzgmF5V6zFkiskdvPaVmfXlCvwoUP0s8AJvgOqn/info.json//degrees").
with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'www.zipcodeapi.com', 'User-Agent'=>'Ruby'}).
to_return(status: 200, body: "{}", headers: {})

WebMock.stub_request(:get, "https://api.darksky.net/forecast/640644acf3d2e971e41cef9646c4f0aa/,").
with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.darksky.net', 'User-Agent'=>'Ruby'}).
to_return(status: 200, body: "{}", headers: {})

WebMock.stub_request(:get, "https://www.zipcodeapi.com/rest/yruKeJMZU3uXpx42ZmxaLpiCyjzgmF5V6zFkiskdvPaVmfXlCvwoUP0s8AJvgOqn/info.json/80210/degrees").
with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'www.zipcodeapi.com', 'User-Agent'=>'Ruby'}).
to_return(status: 200, body: "{\"lat\":\"0.692488\",\"lng\":\"-1.83194\"}", headers: {})

WebMock.stub_request(:get, "https://api.darksky.net/forecast/640644acf3d2e971e41cef9646c4f0aa/0.692488,-1.83194").
with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.darksky.net', 'User-Agent'=>'Ruby'}).
to_return(status: 200, body: "{\"latitude\": \"\", \"longitude\": \"\", \"timezone\": \"\", \"currently\": \{\"time\": 1506456905,
\"summary\":\"Partly Cloudy\",
\"icon\":\"partly-cloudy-night\",
\"precipIntensity\":0.0002,
\"precipProbability\":0.01,
\"precipType\":\"rain\",
\"temperature\":76.17,
\"apparentTemperature\":77.51,
\"dewPoint\":71.49,
\"humidity\":0.85,
\"pressure\":1012.05,
\"windSpeed\":14.37,
\"windGust\":16.57,
\"windBearing\":187,
\"cloudCover\":0.45,
\"uvIndex\":0,
\"ozone\":273.02\}}", headers: {})

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
    sleep 1
    result = File.readlines('temp_file.txt')
    File.delete('temp_file.txt')
    
    assert_equal result.length, 16
    assert_equal result.first[0..4], 'Time:'
    assert_equal result.last[0..5], 'Ozone:'
  end
end
