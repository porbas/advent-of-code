class SonarSweep
  def call(report)
    counter = 0
    (1..report.size).each do |i|
      counter +=1 if report[i] && report[i] > report[i-1]
    end
    counter
  end
end

class SlidingSonarSweep
  def call(report)
    counter = 0
    prev_sum = 0
    (1..report.size).each do |i|
      window = [report[i-1], report[i], report[i+1]].compact
      if window.size == 3 && i>1
        counter +=1 if window.sum > prev_sum
        prev_sum = window.sum
      end
    end
    counter
  end
end

if (input_file = ARGV[0]) =~ /txt$/
  entries = File.readlines(input_file).map {|line| line.to_i}
  puts SonarSweep.new.call(entries)
  puts SlidingSonarSweep.new.call(entries)
end
