class Counter
  def initialize
    @counter_0 = 0
    @counter_1 = 0
  end

  def count!(v)
    case v
    when 0
      @counter_0 += 1
    when 1
      @counter_1 += 1
    else
      raise "invalid value: #{v.inspect}"
    end
  end

  def most_common
    @counter_0 > @counter_1 ? 0 : 1
  end

  def least_common
    @counter_0 > @counter_1 ? 1 : 0
  end
end

class PowerConsumptionCalculator
  def call(lines)
    make_buffers(lines.first.length)

    lines.each do |line|
      line.each_char.with_index do |c,i|
        @buffer[i].count!(c.to_i)
      end
    end

    gamma_bin_str = @buffer.map {|b| b.most_common.to_s }.join("")
    epsilon_bin_str = @buffer.map {|b| b.least_common.to_s }.join("")

    gamma = gamma_bin_str.to_i(2)
    epsilon = epsilon_bin_str.to_i(2)

    gamma * epsilon
  end

  private
  def make_buffers(size)
    @buffer = (1..size).to_a.map { Counter.new }
  end
end


if (input_file = ARGV[0]) =~ /txt$/
  lines = File.readlines(input_file).map(&:strip)
  puts PowerConsumptionCalculator.new.call(lines)
end
