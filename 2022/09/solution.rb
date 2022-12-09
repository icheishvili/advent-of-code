def move(x, y, direction)
  case direction
  when 'R' then [x + 1, y]
  when 'L' then [x - 1, y]
  when 'U' then [x, y - 1]
  when 'D' then [x, y + 1]
  end
end

def follow(hx, hy, tx, ty)
  if hx - tx == 2
    [tx + 1, hy]
  elsif tx - hx == 2
    [tx - 1, hy]
  elsif hy - ty == 2
    [hx, ty + 1]
  elsif ty - hy == 2
    [hx, ty - 1]
  end
end

def lines
  Enumerator.new do |enum|
    File.read('input.txt').lines.map(&:chomp).each do |line|
      direction, magnitude = line.split
      enum << [direction, magnitude.to_i]
    end
  end
end

head = [[0, 0]]
tail = [[0, 0]]
lines.each do |(direction, magnitude)|
  magnitude.times do
    hx, hy = head.last

    head << move(hx, hy, direction)

    hx, hy = head.last
    tx, ty = tail.last

    new_tail = follow(hx, hy, tx, ty)
    tail << new_tail if new_tail
  end
end

puts "Part 1: #{tail.uniq.count}"

knots = []
10.times do
  knots << [[0,0]]
end
lines.each do |(direction, magnitude)|
  magnitude.times do
    x, y = knots[0].last

    knots[0] << move(x, y, direction)
    (knots.count - 1).times do |i|
      hx, hy = knots[i].last
      tx, ty = knots[i + 1].last

      new_tail = follow(hx, hy, tx, ty)
      knots[i + 1] << new_tail if new_tail
    end
  end
end

puts "Part 2: #{knots.last.uniq.count}"
