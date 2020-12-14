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

    it "properly processes input" do
      _(DockingData.new.call(example)).must_equal 165
    end

    let(:example2) do
      <<~EOT.strip.split("\n")
      mask = 000000000000000000000000000000X1001X
      mem[42] = 100
      mask = 00000000000000000000000000000000X0XX
      mem[26] = 1
      EOT
    end

    it "properly processes input" do
      _(DockingData2.new.call(example2)).must_equal 208
    end

  end
end


