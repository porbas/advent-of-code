class Position < Struct.new(:h, :d)
end

class PositionCalculator
  def initialize
    @position = Position.new(0, 0)
  end

  def call(lines)
    lines.each do |line|
      c, v = line.split(" ")
      command = c.to_sym
      value = v.to_i
      send command, value
    end
    @position
  end

  private
  attr_reader :position

  def forward(v)
    @position = Position.new(position.h + v, position.d)
  end

  def down(v)
    @position = Position.new(position.h, position.d + v)
  end

  def up(v)
    @position = Position.new(position.h, position.d - v)
  end
end


class PositionCalculator2 < PositionCalculator
  def initialize
    super
    @aim = 0
  end

  private
  attr_reader :aim

  def forward(v)
    h = position.h + v
    d = position.d + aim * v
    @position = Position.new(h, d)
  end

  def down(v)
    @aim += v
  end

  def up(v)
    @aim -= v
  end
end

if (input_file = ARGV[0]) =~ /txt$/
  lines = File.readlines(input_file)
  position = PositionCalculator.new.call(lines)
  puts position.h * position.d
  position = PositionCalculator2.new.call(lines)
  puts position.h * position.d
end
