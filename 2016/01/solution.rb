def turn(turn, facing)
  case [turn, facing]
  when ['left',  'north'] then 'west'
  when ['left',  'west']  then 'south'
  when ['left',  'south'] then 'east'
  when ['left',  'east']  then 'north'
  when ['right', 'north'] then 'east'
  when ['right', 'east']  then 'south'
  when ['right', 'south'] then 'west'
  when ['right', 'west']  then 'north'
  end
end

input = File.read('input.txt').split(/\s*,\s*/)
directions = input.map do |part|
  {
    turn: part[0] == 'L' ? 'left' : 'right',
    magnitude: part[1..-1].to_i,
  }
end

facing = 'north'
x = 0
y = 0
directions.each do |direction|
  facing = turn(direction[:turn], facing)
  case facing
  when 'north' then y -= direction[:magnitude]
  when 'east'  then x += direction[:magnitude]
  when 'south' then y += direction[:magnitude]
  when 'west'  then x -= direction[:magnitude]
  end
end

puts "Part 1: #{[x, y].map(&:abs).sum}"

facing = 'north'
x = 0
y = 0
seen = [[x, y]]
first_revisited = nil
directions.each do |direction|
  break if first_revisited

  facing = turn(direction[:turn], facing)
  
  direction[:magnitude].times do
    case facing
    when 'north' then y -= 1
    when 'east'  then x += 1
    when 'south' then y += 1
    when 'west'  then x -= 1
    end

    if seen.include?([x, y]) && !first_revisited
      first_revisited = [x, y]
    else
      seen << [x, y]
    end
  end
end

puts "Part 2: #{first_revisited.map(&:abs).sum}"
