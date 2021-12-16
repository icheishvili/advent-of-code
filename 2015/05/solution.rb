def nice?(v)
  vowels = v.chars.count { |c| %w(a e i o u).include?(c) }
  return false if vowels < 3
  return false if v.include?('ab')
  return false if v.include?('cd')
  return false if v.include?('pq')
  return false if v.include?('xy')
  (0..v.size - 1).each do |i|
    return true if v[i] == v[i + 1]
  end
  return false
end

def nice2?(v)
  pairs = Hash.new do |h, k|
    h[k] = []
  end
  (0..v.size - 2).map do |i|
    pairs["#{v[i]}#{v[i + 1]}"] << [i, i + 1]
  end
  return false if pairs.none? do |k, vs|
    vs.flatten.uniq.count >= 4
  end
  (0..v.size - 3).map do |i|
    return true if v[i] == v[i + 2]
  end
  return false
end

lines = File.read('input.txt').lines.map(&:chomp)

result = lines.select do |v|
  nice?(v)
end

puts "Part 1: #{result.count}"

result = lines.select do |v|
  nice2?(v)
end

puts "Part 2: #{result.count}"
