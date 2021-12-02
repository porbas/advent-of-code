require 'test_helper'

require 'day_02_dive'

class Day02Test < Minitest::Test
  EXAMPLE = <<~END.split("\n")
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
  END

  describe PositionCalculator do
    it "returns final position" do
      _(PositionCalculator.new.call(EXAMPLE)).must_equal(Position.new(15, 10))
    end
  end

  describe PositionCalculator2 do
    it "returns final position" do
      _(PositionCalculator2.new.call(EXAMPLE)).must_equal(Position.new(15, 60))
    end
  end
end

