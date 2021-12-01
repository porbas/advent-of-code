class SonarSweep
  def call(report)
    counter = 0
    (1..report.size).each do |i|
      counter +=1 if report[i] && report[i] > report[i-1]
    end
    counter
  end
end
