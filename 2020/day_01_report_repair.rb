entries = File.readlines('input/01.txt').map {|line| line.to_i}

entries.each_with_index do |entry, i|
  complement = entries[i+1..-1].find {|c| entry + c == 2020}
  if complement
    puts "#{entry} + #{complement} = 2020"
    puts "#{entry} * #{complement} = #{entry * complement}"
    break
  end
end
