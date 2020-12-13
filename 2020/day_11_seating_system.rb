
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
        # puts dump m
        # puts "-"*15
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
    @matrix = layout.split("\n").map {|line| parse_line line}
  end

  def parse_line(line)
    line.split('').map {|c| place_factory c}
  end

  def place_factory(character)
    case character
    when '.' then Floor.new
    when 'L' then EmptySeat.new
    when '#' then OccupiedSeat.new
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

  class EmptySeat
    def occupied?
      0
    end

    def next_state(adjacent_seats)
      if adjacent_seats.map(&:occupied?).inject(:+) == 0
        OccupiedSeat.new
      else
        self
      end
    end

    def dump
      "L"
    end
  end

  class OccupiedSeat
    def occupied?
      1
    end

    def next_state(adjacent_seats)
      if adjacent_seats.map(&:occupied?).inject(:+) > 3
        EmptySeat.new
      else
        self
      end
    end

    def dump
      "#"
    end
  end

  class Floor
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

if (input_file = ARGV[0]) =~ /txt$/
  layout = File.read(input_file)
  puts SeatingSystem.new(layout).run_part_one.occupied_seats_count
end
