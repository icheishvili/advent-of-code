depths = File.read('input.txt').lines.map(&:to_i)

increases = depths.select.with_index do |depth, i|
  depths[i + 1] && depth < depths[i + 1]
end

puts "Part 1: #{increases.count}"

increases = (0..depths.size - 4).select do |i|
  depths.slice(i, 3).sum < depths.slice(i + 1, 3).sum
end

puts "Part 2: #{increases.count}"
