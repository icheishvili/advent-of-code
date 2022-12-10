snapshots = {}
x = 1
cycle = 1
File.read('input.txt').each_line do |line|
  instruction, value = line.split
  if instruction == 'noop'
    snapshots[cycle] = x
    cycle += 1
  elsif instruction == 'addx'
    snapshots[cycle] = x
    cycle += 1
    snapshots[cycle] = x
    x += value.to_i
    cycle += 1
  end
end

intervals = [20, 60, 100, 140, 180, 220]
total = intervals.map { |interval| interval * snapshots[interval] }.sum

puts "Part 1: #{total}"

puts "Part 2:"

6.times do |row|
  40.times do |col|
    cycle = row * 40 + col + 1
    x = snapshots[cycle]
    sprite = [x - 1, x, x + 1]
    if sprite.include?(col)
      print "#"
    else
      print "."
    end
  end
  puts
end
