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
    @mask = Bitmask2.new str
  end

  def process_command(address, value)
    @mask.addresses(address).each {|a| @mem[a] = value}
  end
end

class Bitmask2
  def initialize(mask)
    @mask1 = mask.gsub('X', '0').to_i(2)
    @floats = floating_indices mask
  end

  def addresses(val)
    address = val | @mask1
    apply_floating address
  end

  def floating_indices(mask)
    mask.split('').each_with_index.each_with_object([]) {|(c, i), memo| memo << i if c == 'X'}
  end

  def apply_floating(address)
    address_bits = address.to_s(2).rjust(36, '0').split("")
    ret = [address_bits]
    @floats.each do |index|
      ret += float_one_bit(ret, index)
    end
    ret.map(&:join)
  end

  def float_one_bit(addresses, i)
    ret = []
    addresses.each do |address|
      a = address.dup
      toggle_bit a, i
      ret << a
    end
    ret
  end

  def toggle_bit(a, i)
    a[i] = a[i] == '0' ? '1' : '0'
  end
end

if (input_file = ARGV[0]) =~ /txt$/
  entries = File.readlines(input_file)
  puts DockingData.new.call(entries)
  puts DockingData2.new.call(entries)
end
