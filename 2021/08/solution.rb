rows = File.read('input.txt').lines.map do |line|
  parts = line.split('|').map(&:strip)
  {
    input: parts[0].split,
    output: parts[1].split,
  }
end

total = rows.map do |row|
  row[:output].select do |output|
    [2, 4, 3, 7].include?(output.size)
  end.count
end.sum

puts "Part 1: #{total}"

result = rows.map do |row|
  one = row[:input].find do |signal|
    signal.size == 2
  end

  three = row[:input].find do |signal|
    (signal.chars & one.chars).size == 2 &&
      signal.size == 5
  end

  four = row[:input].find do |signal|
    signal.size == 4
  end

  six = row[:input].find do |signal|
    (signal.chars & one.chars).size == 1 &&
      signal.size == 6
  end

  seven = row[:input].find do |signal|
    signal.size == 3
  end

  eight = row[:input].find do |signal|
    signal.size == 7
  end

  nine = row[:input].find do |signal|
    signal.size == 6 &&
      (signal.chars & four.chars).size == 4
  end

  two = row[:input].find do |signal|
    signal.size == 5 &&
      (signal.chars & nine.chars).size == 4
  end

  five = row[:input].find do |signal|
    signal.size == 5 &&
      (signal.chars & nine.chars).size == 5 &&
      (signal.chars & one.chars).size == 1
  end

  zero = (
    row[:input] - [one, two, three, four, five, six, seven, eight, nine]
  ).first

  digits = row[:output].map do |signal|
    case signal.chars.sort
    when zero.chars.sort then 0
    when one.chars.sort then 1
    when two.chars.sort then 2
    when three.chars.sort then 3
    when four.chars.sort then 4
    when five.chars.sort then 5
    when six.chars.sort then 6
    when seven.chars.sort then 7
    when eight.chars.sort then 8
    when nine.chars.sort then 9
    else raise "unknown: #{num}"
    end
  end
  digits.join('').to_i
end

puts "Part 2: #{result.sum}"
