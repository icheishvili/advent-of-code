rows =
  File.read('input.txt').lines.map do |line|
    line.split('x').map(&:to_i)
  end

boxes = rows.map do |row|
  a, b, c = row
  sides = [
    a * b,
    a * c,
    b * c,
  ]
  areas = sides.map { |side| side * 2 }
  areas.sum + sides.min
end

puts "Part 1: #{boxes.sum}"

ribbons = rows.map do |row|
  a, b, c = row
  perimeters = [
    2 * a + 2 * b,
    2 * a + 2 * c,
    2 * b + 2 * c,
  ]
  volume = a * b * c

  perimeters.min + volume
end

puts "Part 2: #{ribbons.sum}"
