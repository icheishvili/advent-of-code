def puts_grid(points)
  max_x = points.map { |p| p[0] }.max
  max_y = points.map { |p| p[1] }.max

  (0..max_y).each do |y|
    line = (0..max_x).map do |x|
      points.include?([x, y]) ? '#' : ' '
    end.join
    puts line
  end
end

def fold(points, fold)
  axis, value = fold

  max_x = points.map { |p| p[0] }.max
  max_y = points.map { |p| p[1] }.max

  points.map do |(x, y)|
    if axis == 'y'
      if y > value
        [x, value - (y - value)]
      else
        [x, y]
      end
    elsif axis == 'x'
      if x > value
        [value - (x - value), y]
      else
        [x, y]
      end
    end
  end
end

points = []
folds = []
File.read('input.txt').lines.map(&:chomp).each do |line|
  if line =~ /,/
    x, y = line.split(',').map(&:to_i)
    points << [x, y]
  elsif line =~ /=/
    line =~ /fold along (x|y)=(\d+)/
    folds << [$1, $2.to_i]
  end
end

puts "Part 1: #{fold(points, folds.first).uniq.count}"

folds.each do |fold|
  points = fold(points, fold)
end

puts 'Part 2:'
puts_grid(points)
