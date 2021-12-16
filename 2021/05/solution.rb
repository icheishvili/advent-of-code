point_pairs = []
File.read('input.txt').lines.each do |line|
  pairs = line.chomp.split(' -> ')
  x1, y1 = pairs[0].split(',').map(&:to_i)
  x2, y2 = pairs[1].split(',').map(&:to_i)
  point_pairs << [[x1, y1], [x2, y2]]
end

vent_map = []
point_pairs.each do |points|
  x1, y1 = points[0]
  x2, y2 = points[1]

  x_min, x_max = [x1, x2].min, [x1, x2].max
  y_min, y_max = [y1, y2].min, [y1, y2].max

  if x1 == x2
    x = x1
    (y_min..y_max).each do |y|
      vent_map[x] ||= []
      vent_map[x][y] ||= 0
      vent_map[x][y] += 1
    end
  elsif y1 == y2
    y = y1
    (x_min..x_max).each do |x|
      vent_map[x] ||= []
      vent_map[x][y] ||= 0
      vent_map[x][y] += 1
    end
  end
end

overlaps = vent_map.flatten.compact.count { |x| x >= 2 }
puts "Part 1: #{overlaps}"

point_pairs.each do |points|
  x1, y1 = points[0]
  x2, y2 = points[1]

  x_min, x_max = [x1, x2].min, [x1, x2].max
  y_min, y_max = [y1, y2].min, [y1, y2].max

  if x_max - x_min == y_max - y_min
    x = x1
    y = y1
    vent_map[x] ||= []
    vent_map[x][y] ||= 0
    vent_map[x][y] += 1
    until x == x2 && y == y2
      if x1 < x2
        x += 1
      else
        x -= 1
      end
      if y1 < y2
        y += 1
      else
        y -= 1
      end
      vent_map[x] ||= []
      vent_map[x][y] ||= 0
      vent_map[x][y] += 1
    end
  end
end

overlaps = vent_map.flatten.compact.count { |x| x >= 2 }
puts "Part 2: #{overlaps}"
