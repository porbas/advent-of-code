class DangerCalculator2
  def call(input_lines)
    @matrix = Matrix.new(
      input_lines.map {|l| Line.new(l)}
    )
    @matrix.score(2)
  end
end

class DangerCalculator
  def call(input_lines)
    @matrix = Matrix.new(
      input_lines.map {|l| Line.new(l)}.select {|l| l.horizontal? || l.vertical?}
    )
    @matrix.score(2)
  end
end

class Matrix
  def initialize(lines)
    @lines = lines
    @matrix = []
    lines.each {|l| add_to_matrix(l)}
  end

  def inspect
    @matrix.map do |row|
      row.map do |cell|
        cell.nil? ? '.' : cell.to_s
      end.join('')
    end.join("\n")
  end

  def score(treshold)
    counter = 0
    @matrix.each do |row|
      Array(row).map do |cell|
        counter +=1 if cell && cell >= treshold
      end
    end
    counter
  end

  private
  def add_to_matrix(l)
    l.points.each do |p|
      @matrix[p.x] ||= []
      @matrix[p.x][p.y] ||= 0
      @matrix[p.x][p.y] += 1
    end
  end
end

class Line
  def initialize(description)
    x1,y1,x2,y2 = description.split(/,|->/).map(&:to_i)
    @p1 = Point.new(x1, y1)
    @p2 = Point.new(x2, y2)
    normalize
  end

  def vertical?
    @p1.x == @p2.x
  end
  def horizontal?
    @p1.y == @p2.y
  end

  def points
    if vertical?
      (@p1.y..@p2.y).map {|y| Point.new(@p1.x, y) }
    elsif horizontal?
      (@p1.x..@p2.x).map {|x| Point.new(x, @p1.y) }
    else
      a = []
      x_iterator.each_with_index do |x,idx|
        a << Point.new(x, y_iterator[idx..idx].first)
      end
      a
    end
  end

  private

  def normalize
    if @p1.x >= @p2.x && @p1.y >= @p2.y
      @p1, @p2 = @p2, @p1
    end
  end

  def x_iterator
    if @p1.x > @p2.x
      @p1.x.downto(@p2.x)
    else
      @p1.x.upto(@p2.x)
    end
  end

  def y_iterator
    if @p1.y > @p2.y
      @p1.y.downto(@p2.y).to_a
    else
      @p1.y.upto(@p2.y).to_a
    end
  end
end

class Point < Struct.new(:x, :y)

end

if (input_file = ARGV[0]) =~ /txt$/
  lines = File.readlines(input_file).map(&:strip)
  puts DangerCalculator.new.call(lines)
  puts DangerCalculator2.new.call(lines)
end
