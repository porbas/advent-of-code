require 'test_helper'

require 'day_03_binary_diagnostic'

class Day03Test < Minitest::Test
  EXAMPLE = <<~END.split("\n")
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
  END

  describe PowerConsumptionCalculator do
    it "returns power consumption" do
      _(PowerConsumptionCalculator.new.call(EXAMPLE)).must_equal(198)
    end
  end

  describe LifeSupportRatingCalculator do
    it "returns life support rate" do
      _(LifeSupportRatingCalculator.new.call(EXAMPLE)).must_equal(230)
    end
  end
end

