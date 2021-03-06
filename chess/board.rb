require_relative 'piece'

class Board
  attr_reader :rows

  def initialize
    @rows = Array.new(8){Array.new(8)}

    8.times do |col|
      self[[1,col]] = Pawn.new(:white, self, [1,col])
    end

    8.times do |col|
      self[[6,col]] = Pawn.new(:black, self, [1,col])
    end

    [[0,:white],[7,:black]].each do |row,color|
      self[[row,0]] = Rook.new(color, self, [row,0])
      self[[row,7]] = Rook.new(color, self, [row,7])

      self[[row,1]] = Knight.new(color, self, [row,1])
      self[[row,6]] = Knight.new(color, self, [row,6])

      self[[row,2]] = Bishop.new(color, self, [row,2])
      self[[row,5]] = Bishop.new(color, self, [row,5])

      self[[row,3]] = Queen.new(color, self, [row,3])
      self[[row,4]] = King.new(color, self, [row,4])

    end

    (2..5).each do |row|
      (0..7).each do |col|
        pos = [row,col]
        self[pos] = NullPiece.instance
      end
    end

  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].is_a?(NullPiece)
      raise NoPieceError.new("No piece here")
    elsif !valid_pos?(end_pos)
      raise IllegalMoveError.new("Can't move here")
    end

    # self[end_pos].position = nil unless self[end_pos].is_a?(NullPiece)
    self[end_pos],self[start_pos] = self[start_pos], NullPiece.instance
    # self[end_pos].position = end_pos
  end

  def valid_pos?(pos)
    pos.all?{|coord| coord.between?(0,7)}
  end

  def []=(pos, value)
    row, col = pos
    rows[row][col] = value
  end

  def [] (pos)
    row, col = pos
    rows[row][col]
  end
  private

end


NoPieceError = Class.new(StandardError)
IllegalMoveError = Class.new(StandardError)

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  p board.rows
end
