class PasswordPhilosophy
  def initialize(policy_class)
    @policy_class = policy_class
  end

  def call(lines)
    parse(lines).map(&:valid?).count(true)
  end
  private

  def parse(lines)
    lines.split("\n").map {|line| parse_password line}
  end

  def parse_password(line)
    tokens = line.split ':'
    policy = @policy_class.new tokens.first
    Password.new tokens.last, policy
  end
end

class Policy
  def initialize(input)
    parse input
  end

  def validate(pass)
    counts = pass.split('').tally
    return false unless counts[@char]

    @min <= counts[@char] && counts[@char] <= @max
  end

  private

  def parse(input)
    limits, @char = input.split(" ")
    @min, @max = limits.split("-").map(&:to_i)
  end
end

class Policy2 < Policy
  def validate(pass)
    (pass[pos1] == @char) ^ (pass[pos2] == @char)
  end

  private

  attr_reader :min, :max
  alias pos1 min
  alias pos2 max
end

class Password
  def initialize(value, policy)
    @value = value
    @policy = policy
  end

  def valid?
    @policy.validate @value
  end
end

if (input_file = ARGV[0]) =~ /txt$/
  passwords = File.read(input_file)
  puts PasswordPhilosophy.new(Policy).call(passwords)
  puts PasswordPhilosophy.new(Policy2).call(passwords)
end
