require 'set'

def dist(sx, sy, bx, by)
  (sx - bx).abs + (sy - by).abs
end

configs = []
File.read('input.txt').each_line do |line|
  parts = line.split
  sx, sy, bx, by = [2, 3, 8, 9].map do |i|
    parts[i].gsub(/x|y|=|,|:/, '').to_i
  end
  configs << [sx, sy, bx, by, dist(sx, sy, bx, by)]
end

def find_ranges(configs, y)
  configs.map do |(sx, sy, bx, by, d)|
    delta = (sy - y).abs
    if delta <= d
      (sx - d + delta .. sx + d - delta)
    end
  end.compact
end

def used_points(configs, y)
  ranges = find_ranges(configs, y)

  pointset = ranges.first.to_set
  ranges.drop(1).each do |range|
    pointset.merge(range)
  end

  pointset - configs.select { |_, _, _, by| by == y }.map { |_, _, bx| bx }
end

points = used_points(configs, 2_000_000)
puts "Part 1: #{points.size}"

(0..4_000_000).each do |y|
  ranges = find_ranges(configs, y)
  x = 0
  while x <= 4_000_000
    r = ranges.find { |r| r.include?(x) }
    if r
      x = r.max + 1
    else
      puts "Part 2: #{x * 4_000_00 + y}"
      exit
      x += 1
    end
  end
end
