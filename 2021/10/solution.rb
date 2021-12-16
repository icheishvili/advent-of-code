lines = File.read('input.txt').lines.map(&:chomp)

token_map = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>',
}

score_map = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137,
}

corrupt_rows = []
incomplete_rows = []
lines.each do |line|
  stack = []
  corrupt = false
  line.chars.each_with_index do |op, position|
    if token_map.keys.include?(op)
      stack << [token_map[op], position]
    elsif token_map.values.include?(op)
      expected_op, prev_pos = stack.pop
      if expected_op != op
        corrupt_rows << {
          line: line,
          prev_pos: prev_pos,
          position: position,
          expected_op: expected_op,
          op: op,
        }
        corrupt = true
        break
      end
    end
  end

  unless corrupt
    incomplete_rows << {
      line: line,
      stack: stack,
    }
  end
end

scores = corrupt_rows.map do |row|
  score_map[row[:op]]
end

puts "Part 1: #{scores.sum}"

completions = []
incomplete_rows.each do |row|
  completion = row[:stack].reverse.map(&:first).join
  completions << completion
end

score_map = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4,
}

scores = completions.map do |completion|
  score = 0
  completion.each_char do |op|
    score *= 5
    score += score_map[op]
  end
  score
end

sorted_scores = scores.sort
half = sorted_scores.size / 2

puts "Part 2: #{sorted_scores.drop(half).first}"
