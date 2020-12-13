require 'test_helper'

require 'day_11_seating_system'

class Day11Test < Minitest::Test
  describe SeatingSystem do
    let(:example) do
      <<~SYSTEM.strip
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
      SYSTEM
    end
    it "properly parses input" do
      _(SeatingSystem.new(example).dump).must_equal example
    end
    it "stabilizes after some iterations with arbitrary number of seats occupied" do
      system = SeatingSystem.new(example).run
      _(system.occupied_seats_count).must_equal 37
    end

    it "works slightly other way in part2" do
      system = SeatingSystemPart2.new(example).run
      _(system.occupied_seats_count).must_equal 26
    end

  end
end

