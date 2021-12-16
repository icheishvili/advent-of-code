require 'set'

changes = File.read('input.txt').lines.map(&:to_i)

puts "Part 1: #{changes.sum}"

current_frequency = 0
seen_frequencies = Set.new
(0..).each do |i|
  current_frequency += changes[i % changes.count]
  if seen_frequencies.include?(current_frequency)
    break
  else
    seen_frequencies << current_frequency
  end
end

puts "Part 2: #{current_frequency}"
