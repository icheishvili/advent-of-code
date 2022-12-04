require 'active_support/all'

ranges = File.read('input.txt').lines.map do |line|
  range1, range2 = line.chomp.split(',')

  range1 = range1.split('-').map(&:to_i)
  range2 = range2.split('-').map(&:to_i)
  
  range1 = (range1[0]..range1[1])
  range2 = (range2[0]..range2[1])

  [range1, range2]
end

coverings = ranges.select do |(r1, r2)|
  r1.cover?(r2) || r2.cover?(r1)
end

puts "Part 1: #{coverings.count}"

overlaps = ranges.select do |(r1, r2)|
  r1.overlaps?(r2)
end

puts "Part 2: #{overlaps.count}"
