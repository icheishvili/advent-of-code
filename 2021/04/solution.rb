def winning_board?(board, called_numbers)
  board.any? { |row| (called_numbers & row).size == row.size } ||
    board.transpose.any? { |row| (called_numbers & row).size == row.size }
end

lines = File.read('input.txt').lines.map(&:chomp)

call_numbers = lines.first.split(',').map(&:to_i)

board_lines = lines.drop(1).reject do |line|
  line.strip == ''
end.map do |line|
  line.split.map(&:to_i)
end
boards = board_lines.each_slice(5).to_a

board = nil
called_numbers = []
call_numbers.each do |call_number|
  called_numbers << call_number
  board = boards.find do |b|
    winning_board?(b, called_numbers)
  end
  if board
    break
  end
end

score = (board.flatten - called_numbers).sum * called_numbers.last
puts "Part 1: #{score}"

board = nil
called_numbers = []
call_numbers.each do |call_number|
  called_numbers << call_number
  if boards.count == 1 && winning_board?(boards.first, called_numbers)
    board = boards.first
    break
  else
    boards = boards.reject { |b| winning_board?(b, called_numbers) }
  end
end

score = (board.flatten - called_numbers).sum * called_numbers.last
puts "Part 2: #{score}"
