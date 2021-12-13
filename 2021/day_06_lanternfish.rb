require 'pry'

class LanternfishSchool

  def initialize(line)
    @meters = []
    line.split(',').map(&:to_i).each {|n| add_fish(n)}
  end

  def add_fish(timer)
    meter = @meters.find {|m| m.timer == timer}
    if !meter
      meter = Meter.new(Lanternfish.new(timer, self))
      @meters << meter
    end
    meter.add
  end

  def new_fish(timer, count)
    @new_meter ||= Meter.new(Lanternfish.new(timer, self))
    count.times { @new_meter.add }
  end

  def call(days)
    (1..days).to_a.each do |d|
      day
      puts "#{d}: #{@meters.count}"
    end
    fish_count
  end

  def day
    @meters.each {|m| m.day}
    @meters <<  @new_meter if @new_meter
    @new_meter = nil
    optimize_meters
  end

  def fish_count
    @meters.sum {|m| m.count}
  end

  def optimize_meters
    @by_timer = {}
    @meters.each do |m|
      @by_timer[m.timer] ||= Meter.new(Lanternfish.new(m.timer, self))
      @by_timer[m.timer].add(m.count)
    end
    @meters = @by_timer.values
  end
end

class Meter
  attr_reader :count

  def initialize(fish)
    @fish = fish
    @count = 0
  end

  def add(c=1)
    @count += c
  end

  def timer
    @fish.timer
  end

  def day
    @fish.day(count)
  end
end

class Lanternfish
  attr_reader :timer
  def initialize(timer, school)
    @timer = timer
    @school = school
  end

  def day(count)
    case @timer
    when 0
      @timer = 6
      @school.new_fish(8, count)
    else
      @timer -= 1
    end
  end
end

if (input_file = ARGV[0]) =~ /txt$/
  lines = File.readlines(input_file).map(&:strip)
  puts LanternfishSchool.new(lines.first).call(80)
  puts LanternfishSchool.new(lines.first).call(256)
end
