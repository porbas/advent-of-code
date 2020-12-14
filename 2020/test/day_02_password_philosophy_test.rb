require 'test_helper'

require 'day_02_password_philosophy'

class Day02Test < Minitest::Test
  describe PasswordPhilosophy do
    let(:example) do
      <<~PASS.strip
      1-3 a: abcde
      1-3 b: cdefg
      2-9 c: ccccccccc
      PASS
    end

    it "gives count of valid passwords" do
      _(PasswordPhilosophy.new(Policy).call(example)).must_equal 2
      _(PasswordPhilosophy.new(Policy2).call(example)).must_equal 1
    end

  end
end

