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

  describe ReportRepair do
    it "searches for two entries" do
      _(ReportRepair.new(2020, 2).search(EXAMPLE)).must_equal 514579
    end

    it "searches for three entries" do
      _(ReportRepair.new(2020, 3).search(EXAMPLE)).must_equal 241861950
    end
  end
end
