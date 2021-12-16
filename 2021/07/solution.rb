positions = File.read('input.txt').chomp.split(',').map(&:to_i)

costs = (0..positions.max).map do |goal_position|
  cost = positions.map do |position|
    (goal_position - position).abs
  end.sum
  [goal_position, cost]
end.to_h

puts "Part 1: #{costs.values.min}"

costs = (0..positions.max).map do |goal_position|
  cost = positions.map do |position|
    diff = (goal_position - position).abs
    cost = (1..diff).sum
  end.sum
  [goal_position, cost]
end.to_h

puts "Part 2: #{costs.values.min}"
