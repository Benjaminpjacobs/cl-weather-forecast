class WeatherFormatter


  def initialize(granularity, forecast)
    @weather = forecast[granularity]
    @granularity = granularity
  end

  def format_weather
    return "That granularity does not seem to be an option, please try again." unless weather
    granularity == 'currently' ? format_single_set(weather) : format_set(weather)
  end

  private 
    attr_reader :weather, :granularity

    def format_set(weather)
      weather['data'].map{|reading| format_single_set(reading)}
                    .unshift("#{granularity.capitalize} Summary: #{weather['summary']}")
                    .compact
                    .join(" \n\n")
    end

    def format_single_set(data)
      data.map{ |measurement, value| icon?(measurement) ? next : format_value(measurement, value) }
          .compact
          .join(" \n")
    end
    
    def format_value(measurement, value)
      if time?(measurement)
        "#{measurement.capitalize}: #{format_time(value)}"
      else
        "#{format_measurement_name(measurement)}: #{value}"
      end
    end

    def format_measurement_name(measurement)
      split_on_letters  = find_capital_letters(measurement)
      words             = split_key(measurement, split_on_letters)
      reformat_measurement(split_on_letters, words)
    end

    def reformat_measurement(split_on_letters, words)
      words.each_with_index.map do |word, idx|
        idx == 0 ? word.capitalize : split_on_letters[idx-1] + word
      end.join(' ')
    end

    def find_capital_letters(measurement)
      measurement.split('').select{|letter| letter == letter.upcase}
    end
    
    def split_key(measurement, split_on_letters)
      split_on_letters.empty? ? [measurement] : measurement.split(/[#{split_on_letters.join}]/) 
    end

    def format_time(time)
      Time.at(time).strftime('%B %d, %Y at %I:%M%p')
    end

    def time?(measurement)
      measurement == 'time'
    end

    def icon?(measurement)
      measurement === 'icon' 
    end
end