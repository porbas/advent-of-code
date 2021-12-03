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

  def most_common(equal_value=nil)
    return equal_value if equal_value && @counter_0 == @counter_1

    @counter_0 > @counter_1 ? 0 : 1
  end

  def least_common(equal_value=nil)
    return equal_value if equal_value && @counter_0 == @counter_1

    @counter_0 > @counter_1 ? 1 : 0
  end
end

class BitCounter
  def call(lines)
    make_buffer(lines.first.length)

    lines.each do |line|
      line.each_char.with_index do |c,i|
        @buffer[i].count!(c.to_i)
      end
    end
    @buffer
  end

  private
  def make_buffer(size)
    @buffer = (1..size).to_a.map { Counter.new }
  end
end

class PowerConsumptionCalculator
  def call(lines)
    counts = BitCounter.new.call(lines)

    gamma_bin_str = counts.map {|b| b.most_common.to_s }.join("")
    epsilon_bin_str = counts.map {|b| b.least_common.to_s }.join("")

    gamma = gamma_bin_str.to_i(2)
    epsilon = epsilon_bin_str.to_i(2)

    gamma * epsilon
  end
end

class LifeSupportRatingCalculator
  def call(lines)

    oxygen_generator_rating_line = filter_lines(lines, :most_common, 1)
    co2_scrubber_rating_line = filter_lines(lines, :least_common, 0)

    oxygen_generator_rating_line.to_i(2) * co2_scrubber_rating_line.to_i(2)
  end

  private
  def filter_lines(lines, method, equal_value, bit_pos=0)
    return lines.first if lines.count == 1

    counts = BitCounter.new.call(lines)
    select_value = counts[bit_pos].send method, equal_value
    selected_lines = lines.select {|line| line[bit_pos] == select_value.to_s}
    filter_lines(selected_lines, method, equal_value, bit_pos+1)
  end
end


if (input_file = ARGV[0]) =~ /txt$/
  lines = File.readlines(input_file).map(&:strip)
  puts PowerConsumptionCalculator.new.call(lines)
  puts LifeSupportRatingCalculator.new.call(lines)
end
