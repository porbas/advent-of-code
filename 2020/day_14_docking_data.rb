class DockingData
  def initialize
    @mem = {}
  end

  def call(lines)
    process lines
    @mem.values.inject(:+)
  end

  private

  def process(lines)
    mask = nil
    lines.each do |line|
      case line
      when /^mask = (.*)$/
        process_mask $1
      when /^mem\[(.*)\] = (.*)$/
        process_command $1.to_i, $2.to_i
      end
    end
  end

  def process_mask(str)
    @mask = Bitmask.new str
  end

  def process_command(address, value)
    @mem[address] = @mask.apply(value)
  end
end

class Bitmask
  def initialize(mask)
    @mask0 = mask.gsub('X', '1').to_i(2)
    @mask1 = mask.gsub('X', '0').to_i(2)
  end

  def apply(val)
    (val & @mask0) | @mask1
  end
end

class DockingData2 < DockingData

  private

  def process_mask(str)

  end

  def process_command(address, value)

  end
end

if (input_file = ARGV[0]) =~ /txt$/
  entries = File.readlines(input_file)
  puts DockingData.new.call(entries)
end
