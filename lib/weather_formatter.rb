class WeatherFormatter
  attr_reader :granularity, :forecast
  def initialize(granularity, forecast)
    @granularity = granularity
    @forecast = forecast
  end

  def format_weather
    weather = forecast[granularity]
    return "There was a network problem trying to reach DarkSky" unless weather
    granularity == 'currently' ? format_single_set(weather) : format_set(weather)
  end

  def format_set(weather)
    set = weather['data'].map do |reading|
      format_single_set(reading)
    end
    set.unshift("#{granularity.capitalize} Summary: #{weather['summary']}")
    set.compact.join(" \n\n")
  end

  def format_single_set(data)
    formatted = data.map do |measurement, value|
      measurement === 'icon' ? next : format_case(measurement, value)
    end.compact.join(" \n")
  end

  def format_time(time)
    Time.at(time).strftime('%B %d, %Y at %I:%M%p')
  end

  def format_measurement(measurement)
    split_on = measurement.split('').find{|letter| letter == letter.upcase}
    words = measurement.split(split_on)
    words.length > 1 ? "#{words[0].capitalize} #{split_on + words[1]}" : words.first.capitalize
  end

  def format_case(measurement, value)
    if measurement == 'time'
      "#{measurement.capitalize}: #{format_time(value)}"
    else
      "#{format_measurement(measurement)}: #{value}"
    end
  end
end