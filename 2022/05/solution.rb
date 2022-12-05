require 'active_support/all'

def initial_lines
  stack_lines = []
  op_lines = []
  more_stack_lines = true
  File.read('input.txt').lines.map(&:chomp).each do |line|
    if line.blank?
      more_stack_lines = false
      next
    end

    if more_stack_lines
      stack_lines << line
    else
      op_lines << line
    end
  end

  [stack_lines, op_lines]
end

def make_stacks
  stack_lines, _ = initial_lines

  stack_width = stack_lines.last.split.count
  stacks = []
  stack_width.times do
    stacks << []
  end

  stack_width.times do |i|
    char_index = (i * (3 + 1)) + 1
    stack_lines[0..-2].map do |line|
      char = line[char_index]
      if char.present?
        stacks[i] << char
      end
    end
  end

  stacks
end

def ops
  _, op_lines = initial_lines
  Enumerator.new do |enum|
    op_lines.each do |line|
      _, count, _, from_ix, _, to_ix = line.split
      enum << [count.to_i, from_ix.to_i - 1, to_ix.to_i - 1]
    end
  end
end

stacks = make_stacks
ops.each do |(count, from_ix, to_ix)|
  count.times do
    stacks[to_ix].unshift(stacks[from_ix].shift)
  end
end

puts "Part 1: #{stacks.map(&:first).join}"

stacks = make_stacks
ops.each do |(count, from_ix, to_ix)|
  tmp = []
  count.times do
    tmp << stacks[from_ix].shift
  end
  count.times do
    stacks[to_ix].unshift(tmp.pop)
  end
end

puts "Part 2: #{stacks.map(&:first).join}"
