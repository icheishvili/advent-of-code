fish = File.read('input.txt').chomp.split(',').map(&:to_i)

buckets = fish.group_by(&:itself).map do |day, list|
  [day, list.count]
end.to_h

new_buckets = buckets
(1..256).each do |i|
  new_buckets = Hash.new(0)
  buckets.each do |day, count|
    if day == 0
      new_buckets[6] += count
      new_buckets[8] += count
    else
      new_buckets[day - 1] += count
    end
  end
  buckets = new_buckets

  case i
  when 80 then puts "Part 1: #{buckets.values.sum}"
  when 256 then puts "Part 2: #{buckets.values.sum}"
  end
end
