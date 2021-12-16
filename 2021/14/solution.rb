lines = File.read('input.txt').lines.map(&:chomp)

polymer = lines.grep(/^[A-Z]+$/).first
mapping = lines.grep(/\s->\s/).map do |line|
  line.split(' -> ').map(&:strip)
end.to_h

buckets = Hash.new(0)
(0..polymer.size - 2).each do |i|
  buckets[polymer.slice(i, 2)] += 1
end

(1..40).each do |step|
  new_buckets = Hash.new(0)
  buckets.each do |k, v|
    if mapping[k]
      new_buckets[k[0] + mapping[k]] += v
      new_buckets[mapping[k] + k[1]] += v
    else
      new_buckets[k] += v
    end
  end
  buckets = new_buckets

  frequencies = buckets.map do |k, v|
    [k.chars.first, v]
  end.group_by(&:first).map do |k, vs|
    [k, vs.map(&:last).sum]
  end.to_h

  frequencies[polymer.chars.last] += 1
  counts = frequencies.values.sort

  if step == 10
    puts "Step 1: #{counts.last - counts.first}"
  elsif step == 40
    puts "Step 2: #{counts.last - counts.first}"
  end
end
