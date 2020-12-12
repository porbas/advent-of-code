
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
    m[1..-2].map do |row|
      row[1..-2].map {|place| place.dump}.join ''
    end.join "\n"
  end

  private

  def parse(layout)
    lines = layout.split("\n").map {|line| '.' + line + '.'}
    special_line = lines.first.gsub(/./, '.')
    lines.unshift special_line
    lines.push special_line
    @matrix = lines.map {|line| parse_line line}
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
      m[y-1][x-1..x+1],
      m[y][x-1], m[y][x+1],
      m[y+1]&.[](x-1..x+1)
    ].flatten
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
  entries = File.readlines(input_file).map {|line| line.to_i}
  puts ReportRepair2.new(2020).search(entries)
  puts ReportRepair3.new(2020).search(entries)
end
