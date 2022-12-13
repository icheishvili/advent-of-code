require 'json'

def compare(a, b)
  if a.is_a?(Integer) && b.is_a?(Integer)
    a < b
  elsif a.is_a?(Integer) && b.is_a?(Array)
    compare([a], b)
  elsif a.is_a?(Array) && b.is_a?(Integer)
    compare(a, [b])
  elsif a.empty? && b.empty?
    true
  elsif a.empty? && b.any?
    true
  elsif a.any? && b.empty?
    false
  elsif a.first == b.first
    compare(a[1..-1], b[1..-1])
  else
    compare(a.first, b.first)
  end
end

groups = File.read('input.txt').lines.each_slice(3).map do |(left, right, _)|
  [JSON.parse(left), JSON.parse(right)]
end

valid_indices = []
index = 1
groups.each do |(left, right)|
  valid_indices << index if compare(left, right)
  index += 1
end

puts "Part 1: #{valid_indices.sum}"

flat = [[[2]], [[6]]]
groups.each do |(left, right)|
  flat << left
  flat << right
end

flat.sort! do |a, b|
  compare(a, b) ? -1 : 1
end

two_index = flat.find_index([[2]]) + 1
six_index = flat.find_index([[6]]) + 1

puts "Part 2: #{two_index * six_index}"
