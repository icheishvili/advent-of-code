def priority_of(char)
  if /[[:upper:]]/.match(char)
    char.ord - 38
  else
    char.ord - 96
  end
end

lines = File.read('input.txt').lines.map do |line|
  line.chomp.chars
end

priorities = []
lines.each do |chars|
  first_half = chars[0..chars.size / 2 - 1]
  second_half = chars[chars.size / 2..-1]

  first_groups = first_half.group_by(&:itself)
  second_groups = second_half.group_by(&:itself)
  common = first_groups.keys & second_groups.keys
  priority = priority_of(common.first)
  priorities << priority
end

puts "Part 1: #{priorities.sum}"

badges = []
lines.each_slice(3) do |group|
  keys1 = group[0].group_by(&:itself).keys
  keys2 = group[1].group_by(&:itself).keys
  keys3 = group[2].group_by(&:itself).keys
  common = keys1 & keys2 & keys3
  badges << common.first
end
badge_sum = badges.map { |char| priority_of(char) }.sum

puts "Part 2: #{badge_sum}"
