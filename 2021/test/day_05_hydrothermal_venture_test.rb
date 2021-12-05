require 'test_helper'

require 'day_05_hydrothermal_venture'

class Day05Test < Minitest::Test
  EXAMPLE = <<~END.split("\n")
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
END

  describe DangerCalculator do
    it "returns number of danger areas" do
      _(DangerCalculator.new.call(EXAMPLE)).must_equal(5)
    end
  end

  describe DangerCalculator2 do
    it "returns number of danger areas" do
      _(DangerCalculator2.new.call(EXAMPLE)).must_equal(12)
    end
  end

end

