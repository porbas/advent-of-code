class ShuttleSearch

  def call_part1(lines)
    departure_ts = lines.first.to_i
    parse_busses lines.last
    departures = @busses.compact.each_with_object({}) do |bus,memo|
      memo[bus.next_departure(departure_ts)] = bus
    end
    ts = departures.keys.min
    bus = departures[ts]
    (ts - departure_ts) * bus.id
  end

  def parse_busses(str)
    @busses = str.split(',').map {|id| Bus.factory id}
  end
end

class Bus
  def self.factory(str)
    new str unless str == 'x'
  end

  def initialize(id)
    @id = id.to_i
  end

  attr_reader :id

  def next_departure(after_timestamp)
    ((after_timestamp / id) + 1) * id
  end

end

if (input_file = ARGV[0]) =~ /txt$/
  entries = File.readlines(input_file)
  puts ShuttleSearch.new.call_part1(entries)
end
