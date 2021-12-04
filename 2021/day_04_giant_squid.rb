

class Bingo
  def call(lines)
    prepare_game(lines)
    play
  end

  private
  def prepare_game(lines)
    @boards = []
    board_lines = []
    lines.each do |line|
      unless @numbers
        @numbers = line.split(',').map(&:strip).map(&:to_i)
        next
      end

      if line == ''
        if board_lines.count > 0
          @boards << Board.new(board_lines)
          board_lines = []
        end
      else
        board_lines << line
      end
    end
    @boards << Board.new(board_lines)
  end

  def play(step=0)
    @boards.each {|b| b.mark!(@numbers[step])}
    winning = @boards.find {|b| b.wins?}
    if winning
      return winning.score * @numbers[step]
    end

    play(step+1)
  end
end

class Board
  def initialize(lines)
    @cols = (1..lines.size).map {Vector.new}
    @rows = (1..lines.size).map {Vector.new}
    lines.each_with_index do |line, x|
      line.split(' ').map(&:strip).map(&:to_i).each_with_index do |number, y|
        cell = Cell.new(number)
        @rows[x].set(cell, y)
        @cols[y].set(cell, x)
      end
    end
  end

  def mark!(number)
    @rows.each {|vector| vector.mark!(number)}
  end

  def wins?
    @rows.any? {|r| r.complete?} || @cols.any? {|c| c.complete?}
  end

  def score
    @rows.sum(&:score)
  end
end

class Vector
  def initialize
    @cells = []
  end

  def set(cell, idx)
    @cells[idx] = cell
  end

  def mark!(number)
    @cells.each {|c| c.mark!(number)}
  end

  def complete?
    @cells.all? {|c| c.marked?}
  end

  def score
    @cells.sum(&:score)
  end
end

class Cell
  def initialize(number)
    @number = number
    @marked = false
  end

  def mark!(number)
    return if marked?
    @marked = number == @number
  end

  def marked?
    @marked
  end

  def score
    marked? ? 0 : @number
  end
end



if (input_file = ARGV[0]) =~ /txt$/
  lines = File.readlines(input_file).map(&:strip)
  puts Bingo.new.call(lines)
end
