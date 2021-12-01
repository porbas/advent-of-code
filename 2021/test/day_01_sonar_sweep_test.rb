require 'test_helper'

require 'day_01_sonar_sweep'

class Day01Test < Minitest::Test
  EXAMPLE = %w(
    199
    200
    208
    210
    200
    207
    240
    269
    260
    263
  ).map(&:to_i)

  describe SonarSweep do
    it "returns count of increases" do
      _(SonarSweep.new.call(EXAMPLE)).must_equal 7
    end
  end
end

