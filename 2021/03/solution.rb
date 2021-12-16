def make_frequencies(lines)
  frequencies = Hash.new do |h, k|
    h[k] = Hash.new(0)
  end
  lines.each do |line|
    line.each_with_index do |bit, i|
      frequencies[i][bit] += 1
    end
  end
  frequencies
end

lines = File.read('input.txt').split.map(&:chomp).map do |line|
  line.chars.map(&:to_i)
end

frequencies = make_frequencies(lines)
gamma_bits = (0..frequencies.size - 1).map do |i|
  frequencies[i][0] > frequencies[i][1] ? '0' : '1'
end
gamma = gamma_bits.join.to_i(2)

epsilon_bits = (0..frequencies.size - 1).map do |i|
  frequencies[i][0] < frequencies[i][1] ? '0' : '1'
end
epsilon = epsilon_bits.join.to_i(2)

puts "Part 1: #{gamma * epsilon}"

o2_generator_lines = lines.dup
(0..frequencies.size - 1).each do |i|
  break if o2_generator_lines.count == 1

  frequencies = make_frequencies(o2_generator_lines)
  o2_generator_lines.select! do |line|
    (line[i] == 0 && frequencies[i][0] > frequencies[i][1]) ||
      (line[i] == 1 && frequencies[i][1] >= frequencies[i][0])
  end
end

co2_scrubber_lines = lines.dup
(0..frequencies.size - 1).each do |i|
  break if co2_scrubber_lines.count == 1

  frequencies = make_frequencies(co2_scrubber_lines)
  co2_scrubber_lines.select! do |line|
    (line[i] == 0 && frequencies[i][0] <= frequencies[i][1]) ||
      (line[i] == 1 && frequencies[i][1] < frequencies[i][0])
  end
end

o2_generator = o2_generator_lines.first.map(&:to_s).join.to_i(2)
co2_scrubber = co2_scrubber_lines.first.map(&:to_s).join.to_i(2)

puts "Part 2: #{o2_generator * co2_scrubber}"
