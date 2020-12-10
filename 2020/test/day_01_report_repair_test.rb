require 'test_helper'

require 'day_01_report_repair'

class Day01Test < Minitest::Test
  EXAMPLE = [
    1721,
     979,
     366,
     299,
     675,
    1456,
  ]

  describe ReportRepair2 do
    it "searches for two entries" do
      _(ReportRepair2.new(2020).search(EXAMPLE)).must_equal 514579
    end
  end

  describe ReportRepair3 do
    it "searches for three entries" do
      _(ReportRepair3.new(2020).search(EXAMPLE)).must_equal 241861950
    end
  end
end
