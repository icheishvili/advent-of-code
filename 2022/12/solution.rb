def build
  elevations = []
  weights = []
  File.read('input.txt').lines.each do |line|
    elevs = line.chomp.chars
    weights << [Float::INFINITY] * elevs.size
    elevations << elevs
  end

  start = nil
  destination = nil
  elevations.each_with_index do |row, i|
    row.each_with_index do |char, j|
      if char == 'S'
        start = [i, j]
      elsif char == 'E'
        destination = [i, j]
      end
    end
  end

  x, y = start
  weights[x][y] = 0
  elevations[x][y] = 'a'

  x, y = destination
  elevations[x][y] = 'z'

  [elevations, weights, start, destination]
end

def djikstra(elevations, weights, start)
  bfs_queue = [start]
  until bfs_queue.empty?
    x, y = bfs_queue.shift

    test_points = []
    test_points << [x - 1, y] if x - 1 >= 0
    test_points << [x + 1, y] if x + 1 < elevations.size
    test_points << [x, y - 1] if y - 1 >= 0
    test_points << [x, y + 1] if y + 1 < elevations[x].size

    test_points.select do |(tx, ty)|
      elevations[x][y].ord - elevations[tx][ty].ord >= -1
    end.select do |(tx, ty)|
      weights[x][y] + 1 < weights[tx][ty]
    end.each do |(tx, ty)|
      weights[tx][ty] = weights[x][y] + 1
      bfs_queue << [tx, ty]
    end
  end
end

elevations, weights, start, destination = build
djikstra(elevations, weights, start)
x, y = destination
puts "Part 1: #{weights[x][y]}"

starts = []
elevations.each_with_index do |row, x|
  row.each_with_index do |elev, y|
    if elev == 'a'
      starts << [x, y]
    end
  end
end

final_weights = []
starts.each do |new_start|
  elevations, weights, old_start, destination = build

  x, y = old_start
  weights[x][y] = Float::INFINITY

  x, y = new_start
  weights[x][y] = 0

  djikstra(elevations, weights, new_start)

  x, y = destination
  final_weights << weights[x][y]
end

puts "Part 2: #{final_weights.min}"
