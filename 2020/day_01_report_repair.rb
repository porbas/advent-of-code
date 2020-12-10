
class ReportRepair
  def initialize(sum, count)
    @sum = sum
    @count = count
  end

  def search(entries)
    entries.each_with_index do |entry, i|
      complement = entries[i+1..-1].find {|c| entry + c == @sum}
      return entry * complement if complement
    end
  end
end

if (input_file = ARGV[0]) =~ /txt$/
  entries = File.readlines(input_file).map {|line| line.to_i}
  puts ReportRepair.new(2020, 2).search(entries)
  puts ReportRepair.new(2020, 3).search(entries)
end
