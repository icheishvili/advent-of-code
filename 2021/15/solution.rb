def read_grid
  File.read('input.txt').lines.map(&:chomp).map do |line|
    line.chars.map do |char|
      {
        risk: char.to_i,
        distance: Float::INFINITY,
        parent: nil,
      }
    end
  end
end

def relax!(grid)
  grid[0][0][:distance] = 0

  queue = [[0,0]]
  until queue.empty?
    x, y = queue.shift
    neighbors = [
      [x + 1, y],
      [x - 1, y],
      [x, y + 1],
      [x, y - 1],
    ].reject do |(nx, ny)|
      nx < 0 || ny < 0 || nx >= grid.first.count || ny >= grid.count
    end.each do |(nx, ny)|
      new_distance = grid[x][y][:distance] + grid[nx][ny][:risk]
      if new_distance < grid[nx][ny][:distance]
        grid[nx][ny][:distance] = new_distance
        grid[nx][ny][:parent] = [x, y]
        queue << [nx, ny]
      end
    end
  end
end

def make_path(grid)
  path = [grid[-1][-1]]
  while path.first[:parent]
    x, y = path.first[:parent]
    path.unshift(grid[x][y])
  end
  path
end

grid = read_grid
relax!(grid)
path = make_path(grid)
total_risk = path.map { |p| p[:risk] }.drop(1).sum

puts "Part 1: #{total_risk}"

grid = read_grid
tile_size = grid.size
4.times do
  grid.each do |row|
    row.slice(-tile_size, tile_size).each do |cell|
      risk = cell[:risk] + 1
      row << {
        risk: (risk) > 9 ? 1 : risk,
        distance: Float::INFINITY,
        parnet: nil,
      }
    end
  end
end

4.times do
  grid.slice(-tile_size, tile_size).each do |row|
    grid << row.map do |cell|
      risk = cell[:risk] + 1
      {
        risk: (risk) > 9 ? 1 : risk,
        distance: Float::INFINITY,
        parnet: nil,
      }
    end
  end
end

relax!(grid)
path = make_path(grid)
total_risk = path.map { |p| p[:risk] }.drop(1).sum

puts "Part 2: #{total_risk}"
