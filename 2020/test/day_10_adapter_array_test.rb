require 'test_helper'

require 'day_10_adapter_array'

class Day10Test < Minitest::Test
  describe AdapterArray do
    let(:short_example) { %w(16 10 15 5 1 11 7 19 6 12 4).map(&:to_i) }
    let(:larger_example) { %w(28 33 18 42 31 14 46 20 48 47 24 23 49 45 19 38 39 11 1 32 25 35 8 17 7 9 4 2 34 10 3).map(&:to_i) }

    it "gives proper diffs product" do
      _(AdapterArray.new(short_example).diffs_product).must_equal 35
      _(AdapterArray.new(larger_example).diffs_product).must_equal 220
    end

    it "gives proper arrangements count" do
      _(AdapterArray.new(short_example).arrangements_count).must_equal 8
      _(AdapterArray.new(larger_example).arrangements_count).must_equal 19208
    end
  end
end

