chars = File.read('input.txt').chomp.chars

floor = 0
chars.each do |c|
  if c == '(' then floor += 1 end
  if c == ')' then floor -= 1 end
end
puts "Part 1: #{floor}"

floor = 0
chars.each.with_index(1) do |c, index|
  if c == '(' then floor += 1 end
  if c == ')' then floor -= 1 end
  if floor < 0
    puts "Part 2: #{index}"
    break
  end
end
