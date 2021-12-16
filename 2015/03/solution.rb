input = File.read('input.txt').chars

x = 0
y = 0
deliveries = Hash.new(0)
deliveries[[0, 0]] += 1
input.each do |c|
  case c
  when '>' then x += 1
  when '<' then x -= 1
  when '^' then y += 1
  when 'v' then y -= 1
  end
  deliveries[[x, y]] += 1
end

puts "Part 1: #{deliveries.count}"

santa_x = 0
santa_y = 0
robosanta_x = 0
robosanta_y = 0
deliveries = Hash.new(0)
deliveries[[0, 0]] += 2
input.each_with_index do |c, index|
  if index % 2 == 0
    case c
    when '>' then santa_x += 1
    when '<' then santa_x -= 1
    when '^' then santa_y += 1
    when 'v' then santa_y -= 1
    end
    deliveries[[santa_x, santa_y]] += 1
  else
    case c
    when '>' then robosanta_x += 1
    when '<' then robosanta_x -= 1
    when '^' then robosanta_y += 1
    when 'v' then robosanta_y -= 1
    end
    deliveries[[robosanta_x, robosanta_y]] += 1
  end
end

puts "Part 2: #{deliveries.count}"
