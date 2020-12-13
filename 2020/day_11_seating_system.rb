
class SeatingSystem
  def initialize(layout)
    parse layout
  end

  def run
    while true
      m = next_state
      if dump(@matrix) == dump(m)
        break
      else
        # puts "-"*15
        # puts dump m
        @matrix = m
      end
    end
    self
  end

  def occupied_seats_count
    @matrix.map do |row|
      row.map do |place|
        place.occupied?
      end.inject(:+)
    end.inject(:+)
  end

  def dump(m=@matrix)
    m.map do |row|
      row.map {|place| place.dump}.join ''
    end.join "\n"
  end

  private

  def parse(layout)
    @matrix = layout.split("\n").each_with_index.map {|line,y| parse_line line, y}
  end

  def parse_line(line, y)
    line.split('').each_with_index.map {|c,x| place_class(c).new(x,y)}
  end

  def place_class(character)
    case character
    when '.' then Floor
    when 'L' then EmptySeat
    when '#' then OccupiedSeat
    end
  end

  attr_reader :matrix
  alias m matrix

  def adjacent_for(x, y)
    [
      adjacent_top(x,y),
      adjacent_top_right(x,y),
      adjacent_right(x,y),
      adjacent_bottom_right(x,y),
      adjacent_bottom(x,y),
      adjacent_bottom_left(x,y),
      adjacent_left(x,y),
      adjacent_top_left(x,y),
    ].compact
  end

  def adjacent_top(x,y)
    return nil if y == 0
    m.dig(y-1, x)
  end
  def adjacent_top_right(x,y)
    return nil if y == 0
    m.dig(y-1, x+1)
  end
  def adjacent_right(x,y)
    m.dig(y, x+1)
  end
  def adjacent_bottom_right(x,y)
    m.dig(y+1, x+1)
  end
  def adjacent_bottom(x,y)
    m.dig(y+1, x)
  end
  def adjacent_bottom_left(x,y)
    return nil if x == 0
    m.dig(y+1, x-1)
  end
  def adjacent_left(x,y)
    return nil if x == 0
    m.dig(y, x-1)
  end
  def adjacent_top_left(x,y)
    return nil if y == 0
    return nil if x == 0
    m.dig(y-1, x-1)
  end

  def next_state
    @matrix.each_with_index.map do |row, y|
      row.each_with_index.map do |place, x|
        place.next_state adjacent_for(x, y)
      end
    end
  end

  class Place
    attr_reader :x, :y

    def initialize(x,y)
      @x = x
      @y = y
    end
  end

  class EmptySeat < Place
    def occupied?
      0
    end

    def next_state(adjacent_seats)
      if adjacent_seats.map(&:occupied?).inject(:+) == 0
        OccupiedSeat.new(x,y)
      else
        self
      end
    end

    def dump
      "L"
    end
  end

  class EmptySeatPart2 < EmptySeat
    def next_state(adjacent_seats)
      if adjacent_seats.map(&:occupied?).inject(:+) == 0
        OccupiedSeatPart2.new(x,y)
      else
        self
      end
    end
  end

  class OccupiedSeat < Place
    def occupied?
      1
    end

    def next_state(adjacent_seats)
      if adjacent_seats.map(&:occupied?).inject(:+) >= 4
        EmptySeat.new(x,y)
      else
        self
      end
    end

    def dump
      "#"
    end
  end

  class OccupiedSeatPart2 < OccupiedSeat
    def next_state(adjacent_seats)
      if adjacent_seats.map(&:occupied?).inject(:+) >= 5
        EmptySeatPart2.new(x,y)
      else
        self
      end
    end
  end

  class Floor < Place
    def occupied?
      0
    end

    def next_state(_)
      self
    end

    def dump
      '.'
    end
  end
end

class SeatingSystemPart2 < SeatingSystem
  private

  def place_class(character)
    case character
    when '.' then Floor
    when 'L' then EmptySeatPart2
    when '#' then OccupiedSeatPart2
    end
  end

  def next_state
    @matrix.each_with_index.map do |row, y|
      row.each_with_index.map do |place, x|
        place.next_state visible_for(x, y)
      end
    end
  end

  def visible_for(x,y)
    [
      visible(:top, x,y),
      visible(:top_right, x,y),
      visible(:right, x,y),
      visible(:bottom_right, x,y),
      visible(:bottom, x,y),
      visible(:bottom_left, x,y),
      visible(:left, x,y),
      visible(:top_left, x,y),
    ].compact
  end

  def visible(direction, x, y)
    meth = method "adjacent_#{direction}"
    place = meth.call(x,y)
    while place && place.kind_of?(Floor)
      place = meth.call(place.x, place.y)
    end
    place
  end
end

if (input_file = ARGV[0]) =~ /txt$/
  layout = File.read(input_file)
  puts SeatingSystem.new(layout).run.occupied_seats_count
  puts SeatingSystemPart2.new(layout).run.occupied_seats_count
end
