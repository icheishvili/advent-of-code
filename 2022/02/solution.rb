scores = []
File.read('input.txt').lines.each do |line|
  my_rock = 'X'
  my_paper = 'Y'
  my_scissors = 'Z'

  his_rock = 'A'
  his_paper = 'B'
  his_scissors = 'C'

  his, mine = line.chomp.split

  score =
    case [his, mine]
    when [his_rock, my_rock] then 1 + 3
    when [his_rock, my_paper] then 2 + 6
    when [his_rock, my_scissors] then 3 + 0
    when [his_paper, my_rock] then 1 + 0
    when [his_paper, my_paper] then 2 + 3
    when [his_paper, my_scissors] then 3 + 6
    when [his_scissors, my_rock] then 1 + 6
    when [his_scissors, my_paper] then 2 + 0
    when [his_scissors, my_scissors] then 3 + 3
    else raise 'unknown combo', line.chomp
    end

  scores << score
end

puts "Part 1: #{scores.sum}"

scores = []
File.read('input.txt').lines.each do |line|
  my_loss = 'X'
  my_draw = 'Y'
  my_win = 'Z'

  his_rock = 'A'
  his_paper = 'B'
  his_scissors = 'C'

  his, mine = line.chomp.split

  score =
    case [his, mine]
    when [his_rock, my_loss] then 3 + 0 # => scissors
    when [his_rock, my_draw] then 1 + 3 # => rock
    when [his_rock, my_win] then 2 + 6 # => paper
    when [his_paper, my_loss] then 1 + 0 # => rock
    when [his_paper, my_draw] then 2 + 3 # => paper
    when [his_paper, my_win] then 3 + 6 # => scissors
    when [his_scissors, my_loss] then 2 + 0 # => paper
    when [his_scissors, my_draw] then 3 + 3 # => scissors
    when [his_scissors, my_win] then 1 + 6 # => rock
    else raise 'unknown combo', line.chomp
    end

  scores << score
end

puts "Part 2: #{scores.sum}"
