class AdapterArray
  def initialize
    @rating = 0
    @diffs = {3 => 1}
  end

  def call(input)
    @input = input.sort
    @input.each {|joltage| plug_in joltage }
    @diffs[1] * @diffs[3]
  end

  private

  def plug_in(joltage)
    diff = joltage - @rating
    @diffs[diff] ||= 0
    @diffs[diff] += 1
    @rating = joltage
  end
end

if (input_file = ARGV[0]) =~ /txt$/
  entries = File.readlines(input_file).map {|line| line.to_i}
  puts AdapterArray.new.call(entries)
end
