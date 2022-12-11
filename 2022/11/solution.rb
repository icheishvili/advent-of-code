require 'active_support/all'

def make_monkeys
  monkeys = []

  monkey = nil
  File.open('input.txt', 'rb').each_line do |line|
    if line =~ /^Monkey (\d+)/
      monkey = {number: $1.to_i, items_inspected: 0}
    elsif line =~ /Starting items: (.*)/
      items = $1.split(',').map(&:to_i)
      monkey[:items] = items
    elsif line =~ /Operation: (.*)/
      parts = $1.split.drop(2)
      left, operand, right = parts
      monkey[:operation] = ->(old) do
        l = left == 'old' ? old : left.to_i
        r = right == 'old' ? old : right.to_i
        if operand == '+'
          l + r
        elsif operand == '*'
          l * r
        end
      end
    elsif line =~ /Test: (.*)/
      parts = $1.split
      monkey[:divisible_by] = $1.split[2].to_i
    elsif line =~ /If true: (.*)/
      parts = $1.split
      monkey[:throw_to_if_true] = $1.split[3].to_i
    elsif line =~ /If false: (.*)/
      parts = $1.split
      monkey[:throw_to_if_false] = $1.split[3].to_i
    elsif line.blank?
      monkeys << monkey
      monkey = nil
    end
  end

  if monkey
    monkeys << monkey
  end

  monkeys
end

monkeys = make_monkeys
20.times do
  monkeys.each do |monkey|
    while monkey[:items].any?
      item = monkey[:items].shift
      new_item = monkey[:operation].call(item)
      new_item = (new_item.to_f / 3).floor.to_i
      new_monkey =
        if new_item % monkey[:divisible_by] == 0
          monkeys[monkey[:throw_to_if_true]]
        else
          monkeys[monkey[:throw_to_if_false]]
        end
      monkey[:items_inspected] += 1
      new_monkey[:items] << new_item
    end
  end
end

product = monkeys.pluck(:items_inspected).sort.reverse.take(2).inject(&:*)
puts "Part 1: #{product}"

monkeys = make_monkeys
gcd = monkeys.pluck(:divisible_by).inject(&:*)
10000.times do |i|
  monkeys.each do |monkey|
    while monkey[:items].any?
      item = monkey[:items].shift
      new_item = monkey[:operation].call(item) % gcd
      new_monkey =
        if new_item % monkey[:divisible_by] == 0
          monkeys[monkey[:throw_to_if_true]]
        else
          monkeys[monkey[:throw_to_if_false]]
        end
      monkey[:items_inspected] += 1
      new_monkey[:items] << new_item
    end
  end
end

product = monkeys.pluck(:items_inspected).sort.reverse.take(2).inject(&:*)
puts "Part 2: #{product}"
