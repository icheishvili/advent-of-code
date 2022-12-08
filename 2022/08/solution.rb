lines = File.read('input.txt').lines.map(&:chomp)

grid = []
lines.each do |line|
  grid << line.each_char.map(&:to_i)
end

visible = 0
grid.size.times do |r|
  grid.size.times do |c|
    tree = grid[r][c]

    edge_vis = r == 0 || c == 0 || r == grid.size - 1 || c == grid.size - 1

    up_vis = (0..r-1).all? { |i| grid[i][c] < tree }
    down_vis = (r+1..grid.size-1).all? { |i| grid[i][c] < tree }
    left_vis = (0..c-1).all? { |i| grid[r][i] < tree }
    right_vis = (c+1..grid.size-1).all? { |i| grid[r][i] < tree }

    if edge_vis || up_vis || down_vis || left_vis || right_vis
      visible += 1
    end
  end
end

puts "Part 1: #{visible}"

scores = []
grid.size.times do |r|
  grid.size.times do |c|
    tree = grid[r][c]

    ups = []
    (0..r-1).each do |i|
      ups << grid[i][c]
    end
    up_range = 0
    ups.reverse.each_with_index do |other, i|
      up_range = i + 1
      break if other >= tree
    end

    downs = []
    (r+1..grid.size-1).each do |i|
      downs << grid[i][c]
    end
    down_range = 0
    downs.each_with_index do |other, i|
      down_range = i + 1
      break if other >= tree
    end

    lefts = []
    (0..c-1).each do |i|
      lefts << grid[r][i]
    end
    left_range = 0
    lefts.reverse.each_with_index do |other, i|
      left_range = i + 1
      break if other >= tree
    end

    rights = []
    (c+1..grid.size-1).each do |i|
      rights << grid[r][i]
    end
    right_range = 0
    rights.each_with_index do |other, i|
      right_range = i + 1
      break if other >= tree
    end

    total_range = up_range * down_range * left_range * right_range
    scores << [total_range, [r, c]]
  end
end

score, _ = scores.sort.last

puts "Part 2: #{score}"
