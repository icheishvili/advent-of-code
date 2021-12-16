lines = File.read('input.txt').lines

commands = lines.map do |line|
  line =~ /(toggle|turn on|turn off) (\d+),(\d+) through (\d+),(\d+)/
  command = $1
  x1 = $2.to_i
  y1 = $3.to_i
  x2 = $4.to_i
  y2 = $5.to_i
  [command, x1, y1, x2, y2]
end

grid = 1000.times.map do
  Array.new(1000, 0)
end

commands.each do |(command, x1, y1, x2, y2)|
  (x1..x2).each do |x|
    (y1..y2).each do |y|
      case command
      when 'turn on' then grid[x][y] = 1
      when 'turn off' then grid[x][y] = 0
      when 'toggle' then grid[x][y] = grid[x][y] == 0 ? 1 : 0
      end
    end
  end
end

puts "Part 1: #{grid.flatten.sum}"

grid = 1000.times.map do
  Array.new(1000, 0)
end

commands.each do |(command, x1, y1, x2, y2)|
  (x1..x2).each do |x|
    (y1..y2).each do |y|
      case command
      when 'turn on' then grid[x][y] += 1
      when 'turn off' then grid[x][y] = [0, grid[x][y] - 1].max
      when 'toggle' then grid[x][y] += 2
      end
    end
  end
end

puts "Part 2: #{grid.flatten.sum}"
