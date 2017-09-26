gem 'minitest'
require 'pry'
require 'minitest/autorun'
require_relative '../lib/weather_formatter.rb'

class WeatherFormatterTest < Minitest::Test
  
  def test_it_exists
    wf = WeatherFormatter.new('currently', {"test" => "test"})
    assert_instance_of WeatherFormatter, wf
  end

  def test_it_formats_currently
    weather = { "latitude"=>0.692488,
                "longitude"=>-1.83194,
                "timezone"=>"Etc/GMT",
                "currently"=>
                {"time"=>1506456905,
                  "summary"=>"Partly Cloudy",
                  "icon"=>"partly-cloudy-night",
                  "precipIntensity"=>0.0002,
                  "precipProbability"=>0.01,
                  "precipType"=>"rain",
                  "temperature"=>76.17,
                  "apparentTemperature"=>77.51,
                  "dewPoint"=>71.49,
                  "humidity"=>0.85,
                  "pressure"=>1012.05,
                  "windSpeed"=>14.37,
                  "windGust"=>16.57,
                  "windBearing"=>187,
                  "cloudCover"=>0.45,
                  "uvIndex"=>0,
                  "ozone"=>273.02
                }
              }
    expected =  "Time: September 26, 2017 at 02:15PM \n" +
                "Summary: Partly Cloudy \n" +
                "Precip Intensity: 0.0002 \n" +
                "Precip Probability: 0.01 \n" +
                "Precip Type: rain \n" +
                "Temperature: 76.17 \n" +
                "Apparent Temperature: 77.51 \n" +
                "Dew Point: 71.49 \n" +
                "Humidity: 0.85 \n" +
                "Pressure: 1012.05 \n" +
                "Wind Speed: 14.37 \n" +
                "Wind Gust: 16.57 \n" +
                "Wind Bearing: 187 \n" +
                "Cloud Cover: 0.45 \n" +
                "Uv Index: 0 \n" +
                "Ozone: 273.02"
    wf = WeatherFormatter.new('currently', weather)
    result = wf.format_weather
    assert_equal expected, result
  end

  def test_it_formats_minutely
    weather = { "latitude"=>0.692488,
                "longitude"=>-1.83194,
                "timezone"=>"Etc/GMT",
                "minutely"=>
                {"summary"=>"Partly cloudy for the hour.",
                 "icon"=>"partly-cloudy-day",
                 "data"=>
                  [
                    {"time"=>1506462240, "precipIntensity"=>0.005, "precipIntensityError"=>0.004, "precipProbability"=>0.01, "precipType"=>"rain"},
                    {"time"=>1506462300, "precipIntensity"=>0.005, "precipIntensityError"=>0.005, "precipProbability"=>0.01, "precipType"=>"rain"},
                    {"time"=>1506462360, "precipIntensity"=>0.005, "precipIntensityError"=>0.004, "precipProbability"=>0.01, "precipType"=>"rain"},
                    {"time"=>1506462420, "precipIntensity"=>0.005, "precipIntensityError"=>0.004, "precipProbability"=>0.01, "precipType"=>"rain"},
                    {"time"=>1506462480, "precipIntensity"=>0.005, "precipIntensityError"=>0.004, "precipProbability"=>0.01, "precipType"=>"rain"}
                  ]
                }
              }
    expected =  "Minutely Summary: Partly cloudy for the hour. \n" +
                "\n" +
                "Time: September 26, 2017 at 03:44PM \n" +
                "Precip Intensity: 0.005 \n" +
                "Precip Intensity Error: 0.004 \n" +
                "Precip Probability: 0.01 \n" +
                "Precip Type: rain \n" +
                "\n" +
                "Time: September 26, 2017 at 03:45PM \n" +
                "Precip Intensity: 0.005 \n" +
                "Precip Intensity Error: 0.005 \n" +
                "Precip Probability: 0.01 \n" +
                "Precip Type: rain \n" +
                "\n" +
                "Time: September 26, 2017 at 03:46PM \n" +
                "Precip Intensity: 0.005 \n" +
                "Precip Intensity Error: 0.004 \n" +
                "Precip Probability: 0.01 \n" +
                "Precip Type: rain \n" +
                "\n" +
                "Time: September 26, 2017 at 03:47PM \n" +
                "Precip Intensity: 0.005 \n" +
                "Precip Intensity Error: 0.004 \n" +
                "Precip Probability: 0.01 \n" +
                "Precip Type: rain \n" +
                "\n" +
                "Time: September 26, 2017 at 03:48PM \n" +
                "Precip Intensity: 0.005 \n" +
                "Precip Intensity Error: 0.004 \n" +
                "Precip Probability: 0.01 \n" +
                "Precip Type: rain"
    wf = WeatherFormatter.new('minutely', weather)
    result = wf.format_weather
    assert_equal expected, result
  end
  
  def test_it_formats_hourly
    weather = { "latitude"=>0.692488,
                "longitude"=>-1.83194,
                "timezone"=>"Etc/GMT",
                "hourly"=>
                {"summary"=>"Mostly cloudy until tomorrow evening.",
                 "icon"=>"partly-cloudy-day",
                 "data"=>
                  [{"time"=>1506456000,
                    "summary"=>"Partly Cloudy",
                    "icon"=>"partly-cloudy-night",
                    "precipIntensity"=>0.0002,
                    "precipProbability"=>0.01,
                    "precipType"=>"rain",
                    "temperature"=>76.24,
                    "apparentTemperature"=>77.58,
                    "dewPoint"=>71.5,
                    "humidity"=>0.85,
                    "pressure"=>1011.95,
                    "windSpeed"=>14.46,
                    "windGust"=>16.66,
                    "windBearing"=>187,
                    "cloudCover"=>0.45,
                    "uvIndex"=>0,
                    "ozone"=>272.84},
                   {"time"=>1506459600,
                    "summary"=>"Partly Cloudy",
                    "icon"=>"partly-cloudy-night",
                    "precipIntensity"=>0.0004,
                    "precipProbability"=>0.02,
                    "precipType"=>"rain",
                    "temperature"=>75.96,
                    "apparentTemperature"=>77.3,
                    "dewPoint"=>71.46,
                    "humidity"=>0.86,
                    "pressure"=>1012.37,
                    "windSpeed"=>14.13,
                    "windGust"=>16.32,
                    "windBearing"=>187,
                    "cloudCover"=>0.46,
                    "uvIndex"=>0,
                    "ozone"=>273.54},
                  ]
                }
              }
    expected =  "Hourly Summary: Mostly cloudy until tomorrow evening. \n" +
                "\n" +
                "Time: September 26, 2017 at 02:00PM \n" +
                "Summary: Partly Cloudy \n" +
                "Precip Intensity: 0.0002 \n" +
                "Precip Probability: 0.01 \n" +
                "Precip Type: rain \n" +
                "Temperature: 76.24 \n" +
                "Apparent Temperature: 77.58 \n" +
                "Dew Point: 71.5 \n" +
                "Humidity: 0.85 \n" +
                "Pressure: 1011.95 \n" +
                "Wind Speed: 14.46 \n" +
                "Wind Gust: 16.66 \n" +
                "Wind Bearing: 187 \n" +
                "Cloud Cover: 0.45 \n" +
                "Uv Index: 0 \n" +
                "Ozone: 272.84 \n" +
                "\n" +
                "Time: September 26, 2017 at 03:00PM \n" +
                "Summary: Partly Cloudy \n" +
                "Precip Intensity: 0.0004 \n" +
                "Precip Probability: 0.02 \n" +
                "Precip Type: rain \n" +
                "Temperature: 75.96 \n" +
                "Apparent Temperature: 77.3 \n" +
                "Dew Point: 71.46 \n" +
                "Humidity: 0.86 \n" +
                "Pressure: 1012.37 \n" +
                "Wind Speed: 14.13 \n" +
                "Wind Gust: 16.32 \n" +
                "Wind Bearing: 187 \n" +
                "Cloud Cover: 0.46 \n" +
                "Uv Index: 0 \n" +
                "Ozone: 273.54"
    wf = WeatherFormatter.new('hourly', weather)
    result = wf.format_weather
    assert_equal expected, result
  end

def test_it_formats_daily
    weather = { "latitude"=>0.692488,
                "longitude"=>-1.83194,
                "timezone"=>"Etc/GMT",
                "daily"=>
                {"summary"=> "Light rain throughout the week, with temperatures bottoming out at 48°F on Sunday.",
                "icon"=> "rain",
                "data"=> [
                  {
                    "time"=> 1453363200,
                    "summary"=> "Rain throughout the day.",
                    "icon"=> "rain",
                    "sunriseTime"=> 1453391560,
                    "sunsetTime"=> 1453424361,
                    "moonPhase"=> 0.43,
                    "precipIntensity"=> 0.1134,
                    "precipIntensityMax"=> 0.1722,
                    "precipIntensityMaxTime"=> 1453392000,
                    "precipProbability"=> 0.87,
                    "precipType"=> "rain",
                    "temperatureMin"=> 41.42,
                    "temperatureMinTime"=> 1453363200,
                    "temperatureMax"=> 53.27,
                    "temperatureMaxTime"=> 1453417200,
                    "apparentTemperatureMin"=> 36.68,
                    "apparentTemperatureMinTime"=> 1453363200,
                    "apparentTemperatureMax"=> 53.27,
                    "apparentTemperatureMaxTime"=> 1453417200,
                    "dewPoint"=> 46.79,
                    "humidity"=> 0.95,
                    "windSpeed"=> 4.26,
                    "windBearing"=> 150,
                    "visibility"=> 4.02,
                    "cloudCover"=> 0.77,
                    "pressure"=> 1009.35,
                    "ozone"=> 326.69
                  },
                  {
                    "time"=> 1453373200,
                    "summary"=> "Rain throughout the day.",
                    "icon"=> "rain",
                    "sunriseTime"=> 1453391560,
                    "sunsetTime"=> 1453424361,
                    "moonPhase"=> 0.43,
                    "precipIntensity"=> 0.1134,
                    "precipIntensityMax"=> 0.1722,
                    "precipIntensityMaxTime"=> 1453392000,
                    "precipProbability"=> 0.87,
                    "precipType"=> "rain",
                    "temperatureMin"=> 41.42,
                    "temperatureMinTime"=> 1453363200,
                    "temperatureMax"=> 53.27,
                    "temperatureMaxTime"=> 1453417200,
                    "apparentTemperatureMin"=> 36.68,
                    "apparentTemperatureMinTime"=> 1453363200,
                    "apparentTemperatureMax"=> 53.27,
                    "apparentTemperatureMaxTime"=> 1453417200,
                    "dewPoint"=> 46.79,
                    "humidity"=> 0.95,
                    "windSpeed"=> 4.26,
                    "windBearing"=> 150,
                    "visibility"=> 4.02,
                    "cloudCover"=> 0.77,
                    "pressure"=> 1009.35,
                    "ozone"=> 326.69
                  }]
                }
              }
    expected =  "Daily Summary: Light rain throughout the week, with temperatures bottoming out at 48°F on Sunday. \n" +
                "\n" +
                "Time: January 21, 2016 at 01:00AM \n" +
                "Summary: Rain throughout the day. \n" +
                "Sunrise Time: January 21, 2016 at 08:52AM \n" +
                "Sunset Time: January 21, 2016 at 05:59PM \n" +
                "Moon Phase: 0.43 \n" +
                "Precip Intensity: 0.1134 \n" +
                "Precip Intensity Max: 0.1722 \n" +
                "Precip Intensity Max Time: January 21, 2016 at 09:00AM \n" +
                "Precip Probability: 0.87 \n" +
                "Precip Type: rain \n" +
                "Temperature Min: 41.42 \n" +
                "Temperature Min Time: January 21, 2016 at 01:00AM \n" +
                "Temperature Max: 53.27 \n" +
                "Temperature Max Time: January 21, 2016 at 04:00PM \n" +
                "Apparent Temperature Min: 36.68 \n" +
                "Apparent Temperature Min Time: January 21, 2016 at 01:00AM \n" +
                "Apparent Temperature Max: 53.27 \n" +
                "Apparent Temperature Max Time: January 21, 2016 at 04:00PM \n" +
                "Dew Point: 46.79 \n" +
                "Humidity: 0.95 \n" +
                "Wind Speed: 4.26 \n" +
                "Wind Bearing: 150 \n" +
                "Visibility: 4.02 \n" +
                "Cloud Cover: 0.77 \n" +
                "Pressure: 1009.35 \n" +
                "Ozone: 326.69 \n" +
                "\n" +
                "Time: January 21, 2016 at 03:46AM \n" +
                "Summary: Rain throughout the day. \n" +
                "Sunrise Time: January 21, 2016 at 08:52AM \n" +
                "Sunset Time: January 21, 2016 at 05:59PM \n" +
                "Moon Phase: 0.43 \n" +
                "Precip Intensity: 0.1134 \n" +
                "Precip Intensity Max: 0.1722 \n" +
                "Precip Intensity Max Time: January 21, 2016 at 09:00AM \n" +
                "Precip Probability: 0.87 \n" +
                "Precip Type: rain \n" +
                "Temperature Min: 41.42 \n" +
                "Temperature Min Time: January 21, 2016 at 01:00AM \n" +
                "Temperature Max: 53.27 \n" +
                "Temperature Max Time: January 21, 2016 at 04:00PM \n" +
                "Apparent Temperature Min: 36.68 \n" +
                "Apparent Temperature Min Time: January 21, 2016 at 01:00AM \n" +
                "Apparent Temperature Max: 53.27 \n" +
                "Apparent Temperature Max Time: January 21, 2016 at 04:00PM \n" +
                "Dew Point: 46.79 \n" +
                "Humidity: 0.95 \n" +
                "Wind Speed: 4.26 \n" +
                "Wind Bearing: 150 \n" +
                "Visibility: 4.02 \n" +
                "Cloud Cover: 0.77 \n" +
                "Pressure: 1009.35 \n" +
                "Ozone: 326.69"
    wf = WeatherFormatter.new('daily', weather)
    result = wf.format_weather
    assert_equal expected, result
  end
  
  def test_it_responds_with_error_if_granularity_missing
    wf = WeatherFormatter.new('currently', {})
    result = wf.format_weather
    expected = 'That granularity does not seem to be an option, please try again.'
    assert_equal expected, result
  end
end
