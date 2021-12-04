class Bingo
  def call(lines)

  end
end

if (input_file = ARGV[0]) =~ /txt$/
  lines = File.readlines(input_file).map(&:strip)
  puts PowerConsumptionCalculator.new.call(lines)
  puts LifeSupportRatingCalculator.new.call(lines)
end
