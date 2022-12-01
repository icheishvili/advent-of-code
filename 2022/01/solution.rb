entries = File.read('input.txt').split("\n").map(&:to_i)
totals = []
current = 0
entries.each do |entry|
  if entry == 0
    totals << current
    current = 0
  end
  current += entry
end
totals << current if current > 0

puts "Part 1: #{totals.sort.reverse.first}"

puts "Part 2: #{totals.sort.reverse.take(3).sum}"
