require 'test_helper'

require 'day_06_lanternfish'

class Day06Test < Minitest::Test
  EXAMPLE = "3,4,3,1,2"

  describe LanternfishSchool do
    it "returns number of fishes after number of days" do
      _(LanternfishSchool.new(EXAMPLE).call(18)).must_equal(26)
      _(LanternfishSchool.new(EXAMPLE).call(80)).must_equal(5934)
    end
  end
end


