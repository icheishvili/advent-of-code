rows = File.read('input.txt').lines.map do |line|
  line.chomp.split('').map(&:to_i)
end

lowest_points = []
(0...rows.count).each do |x|
  (0...rows[x].count).each do |y|
    neighbors = [
      [x - 1, y],
      [x + 1, y],
      [x, y - 1],
      [x, y + 1],
    ].select do |(neighbor_x, neighbor_y)|
      neighbor_x >= 0 &&
        neighbor_y >= 0 &&
        neighbor_x < rows.count &&
        neighbor_y < rows[neighbor_x].count
    end

    lowest = neighbors.all? do |(neighbor_x, neighbor_y)|
      rows[x][y] < rows[neighbor_x][neighbor_y]
    end

    if lowest
      lowest_points << [x, y]
    end
  end
end

result = lowest_points.map do |(x, y)|
  rows[x][y] + 1
end.sum

puts "Part 1: #{result}"

basins = lowest_points.map do |(x, y)|
  seen_points = []

  stack = [[x, y]]
  until stack.empty?
    x, y = stack.pop
    seen_points << [x, y]
    
    neighbors = [
      [x - 1, y],
      [x + 1, y],
      [x, y - 1],
      [x, y + 1],
    ].select do |(neighbor_x, neighbor_y)|
      neighbor_x >= 0 &&
        neighbor_y >= 0 &&
        neighbor_x < rows.count &&
        neighbor_y < rows[neighbor_x].count
    end.reject do |(neighbor_x, neighbor_y)|
      rows[neighbor_x][neighbor_y] == 9
    end

    stack += neighbors - seen_points
  end

  seen_points.uniq
end

largest_basins = basins.map(&:count).sort.reverse.take(3)
puts "Part 2: #{largest_basins.inject(:*)}"
