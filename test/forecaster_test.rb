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
end
