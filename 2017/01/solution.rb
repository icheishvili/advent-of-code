input = File.read('input.txt').chomp

values = input.chars.map(&:to_i)
result = values.select.with_index do |_, i|
  values[i] == values[(i + 1) % values.size]
end

puts "Part 1: #{result.sum}"

result = values.select.with_index do |_, i|
  values[i] == values[(i + (values.size / 2)) % values.size]
end

puts "Part 2: #{result.sum}"
