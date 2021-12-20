require 'binding_of_caller'
require 'pry'

def pushdown_left(n, v)
  left, right = n
  case [left.class, right.class]
  when [Array, Array]
    [pushdown_left(left, v), right]
  when [Array, Integer]
    [pushdown_left(left, v), right]
  when [Integer, Array]
    [left + v, right]
  when [Integer, Integer]
    [left + v, right]
  end
end

def pushdown_right(n, v)
  left, right = n
  case [left.class, right.class]
  when [Array, Array]
    [left, pushdown_right(right, v)]
  when [Array, Integer]
    [left, right + v]
  when [Integer, Array]
    [left, pushdown_right(right, v)]
  when [Integer, Integer]
    [left, right + v]
  end
end

def explode_helper(n, depth)
  left, right = n
  case [left.class, right.class]
  when [Array, Array]
    explosion = explode_helper(left, depth + 1)
    if explosion[:leftover]
      {
        value: [explosion[:value], pushdown_left(right, explosion[:leftover][1])],
        leftover: [explosion[:leftover][0], 0],
      }
    else
      explosion = explode_helper(right, depth + 1)
      if explosion[:leftover]
        {
          value: [pushdown_right(left, explosion[:leftover][0]), explosion[:value]],
          leftover: [0, explosion[:leftover][1]],
        }
      else
        {
          value: [left, explosion[:value]],
        }
      end
    end
  when [Integer, Array]
    explosion = explode_helper(right, depth + 1)
    if explosion[:leftover]
      if explosion[:leftover][0] > 0
        {
          value: [left + explosion[:leftover][0], explosion[:value]],
          leftover: [0, explosion[:leftover][1]],
        }
      else
        {
          value: [left, explosion[:value]],
          leftover: explosion[:leftover],
        }
      end
    else
      {value: [left, right]}
    end
  when [Array, Integer]
    explosion = explode_helper(left, depth + 1)
    if explosion[:leftover]
      if explosion[:leftover][1] > 0
        {
          value: [explosion[:value], right + explosion[:leftover][1]],
          leftover: [explosion[:leftover][0], 0],
        }
      else
        {
          value: [explosion[:value], right],
          leftover: explosion[:leftover],
        }
      end
    else
      {value: [left, right]}
    end
  when [Integer, Integer]
    if depth >= 5
      {value: 0, leftover: [left, right]}
    else
      {value: [left, right]}
    end
  end
end

def explode(n)
  result = explode_helper(n, 1)
  result[:value]
end

def split_helper(v)
  if v >= 10
    [(v / 2.0).floor, (v / 2.0).ceil]
  else
    v
  end
end

def split(n)
  left, right = n
  case [left.class, right.class]
  when [Array, Array]
    left_split = split(left)
    if left != left_split
      [left_split, right]
    else
      right_split = split(right)
      [left, right_split]
    end
  when [Array, Integer]
    left_split = split(left)
    if left != left_split
      [left_split, right]
    else
      [left, split_helper(right)]
    end
  when [Integer, Array]
    left_split = split_helper(left)
    if left != left_split
      [left_split, right]
    else
      [left, split(right)]
    end
  when [Integer, Integer]
    left_split = split_helper(left)
    if left != left_split
      [left_split, right]
    else
      [left, split_helper(right)]
    end
  end
end

def reduce(n)
  state = 'explode'
  loop do
    case state
    when 'explode'
      new_n = explode(n)
      if n == new_n
        state = 'split'
      else
        n = new_n
      end
    when 'split'
      new_n = split(n)
      if n == new_n
        break
      else
        state = 'explode'
        n = new_n
      end
    end
  end
  n
end

def add(left, right)
  if left
    reduce([left, right])
  else
    reduce(right)
  end
end

def magnitude(n)
  left, right = n
  case [left.class, right.class]
  when [Array, Array]
    3 * magnitude(left) + 2 * magnitude(right)
  when [Integer, Array]
    3 * left + 2 * magnitude(right)
  when [Array, Integer]
    3 * magnitude(left) + 2 * right
  when [Integer, Integer]
    3 * left + 2 * right
  end
end

numbers = File.read('input.txt').lines.map do |line|
  eval(line)
end

total = nil
numbers.each do |number|
  total = add(total, number)
end

puts "Part 1: #{magnitude(total)}"

magnitudes = []
numbers.each do |n1|
  numbers.each do |n2|
    if n1 != n2
      magnitudes << magnitude(add(n1, n2))
      magnitudes << magnitude(add(n2, n1))
    end
  end
end

puts "Part 2: #{magnitudes.max}"
