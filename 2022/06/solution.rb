input = File.read('input.txt').chomp
input.size.times do |i|
  slice = input[i..i + 3]
  if slice.chars.uniq.count == 4
    puts "Part 1: #{i + 4}"
    break
  end
end

input.size.times do |i|
  slice = input[i..i + 13]
  if slice.chars.uniq.count == 14
    puts "Part 2: #{i + 14}"
    break
  end
end
