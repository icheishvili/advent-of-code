def build_tree(lines)
  parents = [{}]

  lines.each do |line|
    if line.start_with?('$')
      cmd = line[2..]
      if cmd.start_with?('cd')
        dest = cmd[3..]
        case dest
        when '/' then parents = parents.take(1)
        when '..' then parents.pop
        else
          parents.last[dest] = {}
          parents << parents.last[dest]
        end
      end
    elsif line.start_with?('dir')
      dirname = line[4..]
      parents.last[dirname] = {}
    else
      size, filename = line.split
      parents.last[filename] = size.to_i
    end
  end

  parents.first
end

def print_tree(t, indent: 0)
  t.each do |k, v|
    if v.is_a?(Integer)
      puts "#{' ' * indent} #{v} #{k} (file)"
    elsif v.is_a?(Array)
      puts "#{' ' * indent} #{v} #{k} (file)"
    else
      puts "#{' ' * indent} #{sizeof(v)} #{k} (dir)"
      print_tree(v, indent: indent + 2)
    end
  end
end

def sizeof(t)
  if t.is_a?(Integer)
    t
  else
    direct_size = 0
    indirect_size = 0
    t.each do |_, v|
      if v.is_a?(Integer)
        direct_size += v
      else
        indirect_size += sizeof(v)
      end
    end
    direct_size + indirect_size
  end
end

def find_dirs_pt1(t)
  result = []
  t.each do |k, v|
    if v.is_a?(Hash)
      size = sizeof(v)
      result << [k, size] if size <= 100_000
      result += find_dirs_pt1(v)
    end
  end
  result
end

lines = File.read('input.txt').lines.map(&:chomp)
tree = build_tree(lines)

pairs = find_dirs_pt1(tree)
part1 = pairs.map { |pair| pair[1] }.sum
puts "Part 1: #{part1}"

def find_dirs_pt2(t)
  result = []
  t.each do |k, v|
    if v.is_a?(Hash)
      size = sizeof(v)
      result << [k, size] if size >= 10822529
      result += find_dirs_pt2(v)
    end
  end
  result
end

need_free_space = 30_000_000
total_space = 70_000_000
used_space = sizeof(tree)
free_space = total_space - used_space
to_delete = need_free_space - free_space

pairs = find_dirs_pt2(tree)
candidates_to_remove = pairs.select { |(name, size)| size >= to_delete }
_, size = candidates_to_remove.sort_by { |(_, size)| size }.first
puts "Part 2: #{size}"
