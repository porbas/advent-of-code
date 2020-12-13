class PasswordPhilosophy
  def initialize(lines)
    @passwords = parse lines
  end

  def call
    @passwords.map(&:valid?).count(true)
  end
  private

  def parse(lines)
    lines.split("\n").map {|line| parse_password line}
  end

  def parse_password(line)
    tokens = line.split ':'
    policy = Policy.new tokens.first
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
class Password
  def initialize(value, policy)
    @value = value
    @policy = policy
  end

  def valid?
    @policy.validate @value
  end
end
