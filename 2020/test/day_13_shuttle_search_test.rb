require 'test_helper'

require 'day_13_shuttle_search'

class Day13Test < Minitest::Test
  describe ShuttleSearch do
    let(:example) do
      <<~EOT.strip.split("\n")
      939
      7,13,x,x,59,x,31,19
      EOT
    end

    it "properly processes input for part1" do
      _(ShuttleSearch.new.call_part1(example)).must_equal 295
    end

  end
end


