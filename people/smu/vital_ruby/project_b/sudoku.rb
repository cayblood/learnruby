class Board
  
  attr_accessor :board
  
  def initialize(name)
    @board = []
    read_file name
  end
  
  def read_file(name)
    open(name).each do |line|
      line.strip.each_char {|c| @board << c }
    end
  end

  def get_row(row_index)
    @board.slice(row_index * 9, 9)
  end
  
  def is_row_valid?(row_index)
    get_row(row_index).sort.join.eql? "123456789"
  end

  def get_col(col_offset)
    return (0..8).map{|i| @board[col_offset + (i * 9)] }
  end

  def is_col_valid?(col_offset)
    get_col(col_offset).sort.join.eql? "123456789"
  end
  
  def get_box_offset(box_index)
    o = box_index * 3
    if box_index > 5
      o += 9 * 4
    elsif box_index > 2
      o += 9 * 2
    end
    o
  end
  
  def get_box(box_index)
    [0,1,2,9,10,11,18,19,20].map{|offset| @board[offset + (get_box_offset box_index) ]}
  end
  
  def is_box_valid?(box_index)
    get_box(box_index).sort.join.eql? "123456789"
  end
  
end

describe Board do
  
  it "it should read a puzzle" do
    b = Board.new("puzzles/easy1.sud")  
    b.board.size.should eq(81)
  end

  it "it should get the first row" do
    b = Board.new("puzzles/solved.sud")  
    b.get_row(0).should eq("325618497".chars.to_a)
  end

  it "it should validate that rows are solved" do
    b = Board.new("puzzles/solved.sud")  
    (0..8).each{ |i| b.is_row_valid?(i).should eq(true) }
  end

  it "it should get the first col" do
    b = Board.new("puzzles/solved.sud")  
    b.get_col(2).should eq("564927381".chars.to_a)
  end
  
  it "it should validate that columns are valid" do
    b = Board.new("puzzles/solved.sud")  
    (0..8).each{ |i| b.is_col_valid?(i).should eq(true) }
  end

  it "it should get the first box" do
    b = Board.new("puzzles/solved.sud")  
    b.get_box(1).should eq("618924537".chars.to_a)
    b.get_box(3).should eq("569142837".chars.to_a)
    b.get_box(8).should eq("926143578".chars.to_a)
  end

  it "it should validate that boxes are valid" do
    b = Board.new("puzzles/solved.sud")  
    (0..8).each{ |i| b.is_box_valid?(i).should eq(true) }
  end

end