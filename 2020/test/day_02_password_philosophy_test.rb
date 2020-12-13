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
      _(PasswordPhilosophy.new(example).call).must_equal 2
    end

  end
end

