def read_grid
  File.read('input.txt').lines.map do |line|
    line.chomp.chars.map(&:to_i)
  end
end

def put_grid(grid)
  grid.each do |row|
    row.each do |v|
      if v == 0
        print "\e[31m#{v}"
      else
        print "\e[0m#{v}"
      end
    end
    print "\e[0m"
    puts
  end
end

def neighbors(i, j, size)
  [
    [i - 1, j - 1],
    [i - 1, j + 1],
    [i + 1, j - 1],
    [i + 1, j + 1],
    [i - 1, j],
    [i + 1, j],
    [i, j + 1],
    [i, j - 1],
  ].reject do |(i, j)|
    i < 0 || i >= size || j < 0 || j >= size
  end
end

grid = read_grid

flashes = 0
(1..).each do |step|
  new_flashes = 0
  queue = []

  grid.each_with_index do |row, x|
    row.each_with_index do |col, y|
      grid[x][y] += 1
      if grid[x][y] == 10
        queue << [x, y]
      end
    end
  end

  until queue.empty?
    x, y = queue.pop
    neighbors(x, y, grid.size).each do |(x, y)|
      grid[x][y] += 1
      if grid[x][y] == 10
        queue << [x, y]
      end
    end
  end

  grid.each_with_index do |row, x|
    row.each_with_index do |col, y|
      if grid[x][y] > 9
        grid[x][y] = 0 
        new_flashes += 1
      end
    end
  end

  flashes += new_flashes

  if step == 100
    puts "Part 1: #{flashes}"
  end

  if new_flashes == 100
    puts "Part 2: #{step}"
    break
  end
end
