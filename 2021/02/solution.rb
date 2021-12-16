commands = File.read('input.txt').lines.map do |line|
  parts = line.split(/\s+/)
  {
    direction: parts[0],
    magnitude: parts[1].to_i,
  }
end

x = 0
y = 0
commands.each do |command|
  case command[:direction]
  when 'up' then y -= command[:magnitude]
  when 'down' then y += command[:magnitude]
  when 'forward' then x += command[:magnitude]
  end
end

puts "Part 1: #{x * y}"

x = 0
y = 0
aim = 0
commands.each do |command|
  case command[:direction]
  when 'up' then aim -= command[:magnitude]
  when 'down' then aim += command[:magnitude]
  when 'forward'
    x += command[:magnitude]
    y += command[:magnitude] * aim
  end
end

puts "Part 1: #{x * y}"
