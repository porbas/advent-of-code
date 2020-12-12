class AdapterArray
  def initialize(input)
    @input = longest_chain input.sort
    @diffs = @input
      .each_cons(2)
      .map {|(x,y)| y-x}
  end

  def diffs_product
    counts = @diffs.tally
    counts[1] * counts[3]
  end

  FACTORS = {
    1 => 2,
    2 => 4,
    3 => 7,
  }

  def arrangements_count
    @pull_outs = @diffs.each_cons(2)
      .map {|fragment| fragment.inject(:+) < 3}
    total = 1
    consecutive_pulls = 0
    @pull_outs.each do |pull|
      if pull
        consecutive_pulls += 1
      else
        total *= FACTORS[consecutive_pulls] if consecutive_pulls > 0
        consecutive_pulls = 0
      end
    end
    total
  end

  private

  def longest_chain(joltages)
    [0] + joltages + [joltages.last + 3]
  end
end

if (input_file = ARGV[0]) =~ /txt$/
  entries = File.readlines(input_file).map {|line| line.to_i}
  puts AdapterArray.new(entries).diffs_product
  puts AdapterArray.new(entries).arrangements_count
end
