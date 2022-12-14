require 'pry'
require 'binding_of_caller'

point_sets = File.read('input.txt').lines.map(&:chomp).map do |line|
  points = line.split(' -> ')
  points.map do |point|
    point.split(',').map(&:to_i)
  end
end

air = '.'
sand = 'o'
sand_source = '+'
rock = '#'

grid_width = 0
grid_height = 0
point_sets.each do |points|
  points.each do |(x, y)|
    grid_width = [grid_width, x].max
    grid_height = [grid_height, y].max
  end
end
grid_height += 3
grid_width *= 2

grid = []
grid_height.times do
  grid << [air] * grid_width
end
grid[0][500] = sand_source

point_sets.each do |points|
  points.zip(points.drop(1))[0..-2].each do |(p1, p2)|
    if p1[0] > p2[0]
      y = p1[1]
      (p2[0]..p1[0]).each do |x|
        grid[y][x] = rock
      end
    elsif p2[0] > p1[0]
      y = p1[1]
      (p1[0]..p2[0]).each do |x|
        grid[y][x] = rock
      end
    elsif p1[1] > p2[1]
      x = p1[0]
      (p2[1]..p1[1]).each do |y|
        grid[y][x] = rock
      end
    elsif p2[1] > p1[1]
      x = p1[0]
      (p1[1]..p2[1]).each do |y|
        grid[y][x] = rock
      end
    end
  end
end

def print_grid(grid)
  grid.each do |row|
    row[450..550].each do |col|
      print col
    end
    puts
  end
  puts
end

loop do
  y = 0
  x = 500
  loop do
    break if y == grid_height - 1

    if grid[y + 1][x] == air
      y += 1
    elsif x - 1 >= 0 && grid[y + 1][x - 1] == air
      y += 1
      x -= 1
    elsif x + 1 < grid_width && grid[y + 1][x + 1] == air
      y += 1
      x += 1
    else
      break
    end
  end

  break if (y..grid_height - 1).all? { |by| grid[by][x] == air }

  grid[y][x] = sand
end

#print_grid(grid)

counts = grid.map do |row|
  row.count do |col|
    col == sand
  end
end
puts "Part 1: #{counts.sum}"

grid_width.times do |x|
  grid[-1][x] = rock
end

loop do
  y = 0
  x = 500
  loop do
    break if y == grid_height - 1

    if grid[y + 1][x] == air
      y += 1
    elsif x - 1 >= 0 && grid[y + 1][x - 1] == air
      y += 1
      x -= 1
    elsif x + 1 < grid_width && grid[y + 1][x + 1] == air
      y += 1
      x += 1
    else
      break
    end
  end

  grid[y][x] = sand

  break if grid[0][500] == sand
end

#print_grid(grid)

counts = grid.map do |row|
  row.count do |col|
    col == sand
  end
end
puts "Part 2: #{counts.sum}"
