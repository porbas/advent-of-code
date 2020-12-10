
class ReportRepair2
  def initialize(sum)
    @sum = sum
  end

  def search(entries)
    entries.each_with_index do |entry, i|
      complement = entries[i+1..-1].find {|c| entry + c == @sum}
      return entry * complement if complement
    end
    nil
  end
end

class ReportRepair3
  def initialize(sum)
    @sum = sum
  end

  def search(entries)
    entries.each_with_index do |entry, i|
      complement = ReportRepair2.new(@sum - entry).search(entries[i+1..-1])
      return entry * complement if complement
    end
    nil
  end
end

if (input_file = ARGV[0]) =~ /txt$/
  entries = File.readlines(input_file).map {|line| line.to_i}
  puts ReportRepair2.new(2020).search(entries)
  puts ReportRepair3.new(2020).search(entries)
end
