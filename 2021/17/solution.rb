input = File.read('input.txt').chomp
input.sub!('target area: ', '')
parts = input.split(/\s*,\s*/)

goal_x = nil
goal_y = nil

parts.each do |part|
  left, right = part[2..-1].split('..').map(&:to_i).sort
  case part.chars.first
  when 'x' then goal_x = (left..right)
  when 'y' then goal_y = (left..right)
  end
end

max_try_x = goal_x.map(&:abs).max * 3
max_try_y = goal_y.map(&:abs).max * 3

paths = []
(-max_try_x..max_try_x).each do |vx0|
  (-max_try_y..max_try_y).each do |vy0|
    path = {
      vx0: vx0,
      vy0: vy0,
      points: [],
    }
    x = 0
    y = 0
    vx = vx0
    vy = vy0
    (1..max_try_x).each do |step|
      path[:points] << [x, y]
      if goal_x.include?(x) && goal_y.include?(y)
        paths << path
        break
      end
      x += vx
      y += vy
      if vx > 0
        vx -= 1
      elsif vx < 0
        vx += 1
      end
      vy -= 1
    end
  end
end

peaks = paths.map do |path|
  path[:points].map { |(x, y)| y }.max
end

puts "Part 1: #{peaks.max}"

puts "Part 2: #{paths.count}"
