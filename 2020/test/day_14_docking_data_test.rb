require 'test_helper'

require 'day_14_docking_data'

class Day11Test < Minitest::Test
  describe DockingData do
    let(:example) do
      <<~EOT.strip.split("\n")
      mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
      mem[8] = 11
      mem[7] = 101
      mem[8] = 0
      EOT
    end

    it "properly parses input" do
      _(DockingData.new.call(example)).must_equal 165
    end
  end
end


