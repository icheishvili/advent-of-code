require 'digest/md5'

input = File.read('input.txt').chomp

(0..).each do |i|
  to_hash = "#{input}#{i}"
  md5 = Digest::MD5.hexdigest(to_hash)
  if md5.slice(0, 5) == '00000'
    puts "Part 1: #{i}"
    break
  end
end

(0..).each do |i|
  to_hash = "#{input}#{i}"
  md5 = Digest::MD5.hexdigest(to_hash)
  if md5.slice(0, 6) == '000000'
    puts "Part 2: #{i}"
    break
  end
end
