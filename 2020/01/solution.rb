numbers = File.read('input.txt').lines.map(&:to_i)

sum_to_2020 = nil
numbers.each do |n1|
  break if sum_to_2020

  numbers.each do |n2|
    if n1 + n2 == 2020
      sum_to_2020 = [n1, n2]
      break
    end
  end
end

puts "Part 1: #{sum_to_2020.inject(&:*)}"

sum_to_2020 = nil
numbers.each do |n1|
  break if sum_to_2020

  numbers.each do |n2|
    break if sum_to_2020

    numbers.each do |n3|
      if n1 + n2 + n3 == 2020
        sum_to_2020 = [n1, n2, n3]
        break
      end
    end
  end
end

puts "Part 2: #{sum_to_2020.inject(&:*)}"
