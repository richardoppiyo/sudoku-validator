class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    # Your code here

    # Split the given puzzle string into rows and convert each row into a list of numbers
  #  newp = @puzzle_string.tr('^0-9', '')  
  puzzle = @puzzle_string.split("\n").map { |row| row.split(" ").map(&:to_i) }

  #  puts puzzle

  # Check if each row contains numbers from 1 to 9 without repetition
  puzzle.each do |row|
    if row.sort != (1..9).to_a
      return "Sudoku is invalid."
    end
  end

  # Check if each column contains numbers from 1 to 9 without repetition
  (0...9).each do |col|
    column = puzzle.map { |row| row[col] }
    if column.sort != (1..9).to_a
      return "Sudoku is invalid."
    end
  end

  # Check if the puzzle has 9 rows and 9 columns
  if puzzle.length != 9 || puzzle[0].length != 9
    return "Sudoku invalid."
  end


  # Check if each 3x3 sub-grid contains numbers from 1 to 9 without repetition
  (0...9).step(3).each do |row|
    (0...9).step(3).each do |col|
      sub_grid = puzzle[row...row+3].map { |row| row[col...col+3] }.flatten
      if sub_grid.sort != (1..9).to_a
        return "Sudoku is valid but incomplete."
      end
    end
  end


  # If the puzzle passes all checks, it is a valid Sudoku puzzle
  "Sudoku is valid."
   end
end



# Define a sample Sudoku puzzle string
# puzzle_string = <<-EOS
# 5 3 0 0 7 0 0 0 0
# 6 0 0 1 9 5 0 0 0
# 0 9 8 0 0 0 0 6 0
# 8 0 0 0 6 0 0 0 3
# 4 0 0 8 0 3 0 0 1
# 7 0 0 0 2 0 0 0 6
# 0 6 0 0 0 0 2 8 0
# 0 0 0 4 1 9 0 0 5
# 0 0 0 0 8 0 0 7 9
# EOS

puzzle_string = <<-EOS
8 5 9 6 1 2 4 3 0
7 2 3 8 5 4 1 6 9
1 6 4 3 7 9 5 2 8
9 8 6 1 4 7 3 5 2
3 7 5 2 6 8 9 1 4
2 4 1 5 9 3 7 8 6
4 3 2 9 8 1 6 7 5
6 1 7 4 2 5 8 9 3
5 9 8 7 3 6 2 4 1
EOS

# Check the given Sudoku puzzle
puts Validator.validate(puzzle_string)