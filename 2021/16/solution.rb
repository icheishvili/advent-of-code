def hex2bin(hex)
  hex.chars.map do |c|
    case c
    when '0' then '0000'
    when '1' then '0001'
    when '2' then '0010'
    when '3' then '0011'
    when '4' then '0100'
    when '5' then '0101'
    when '6' then '0110'
    when '7' then '0111'
    when '8' then '1000'
    when '9' then '1001'
    when 'A' then '1010'
    when 'B' then '1011'
    when 'C' then '1100'
    when 'D' then '1101'
    when 'E' then '1110'
    when 'F' then '1111'
    end
  end.join
end

def decode_literal_value(bits)
  buffer = []
  loop do
    part, bits = bits.take(5), bits.drop(5)
    buffer += part.drop(1)
    break if part.first == '0'
  end
  [buffer.join.to_i(2), bits]
end

def decode(bits)
  version, bits = bits.take(3).join.to_i(2), bits.drop(3)
  type_id, bits = bits.take(3).join.to_i(2), bits.drop(3)
  if type_id == 4
    literal_value, bits = decode_literal_value(bits)
    [
      {
        version: version,
        type_id: type_id,
        value: literal_value,
      },
      bits,
    ]
  else
    length_type_id, bits = bits.first.to_i(2), bits.drop(1)
    if length_type_id == 0
      sub_packet_length, bits = bits.take(15).join.to_i(2), bits.drop(15)
      sub_packets = []
      remaining_bits, bits =
        bits.take(sub_packet_length), bits.drop(sub_packet_length)
      while remaining_bits.count > 0
        sub_packet, remaining_bits = decode(remaining_bits)
        sub_packets << sub_packet
      end
      [
        {
          version: version,
          type_id: type_id,
          packets: sub_packets,
        },
        bits,
      ]
    else
      sub_packet_count, bits = bits.take(11).join.to_i(2), bits.drop(11)
      sub_packets = []
      sub_packet_count.times do
        sub_packet, bits = decode(bits)
        sub_packets << sub_packet
      end
      remaining_bits = bits
      [
        {
          version: version,
          type_id: type_id,
          packets: sub_packets,
        },
        bits,
      ]
    end
  end
end

def version_sum(packet)
  packet[:version] +
    (packet[:packets] || []).sum { |sub_packet| version_sum(sub_packet) }
end

def evaluate(packet)
  case packet[:type_id]
  when 0
    packet[:packets].map { |sub_packet| evaluate(sub_packet) }.sum
  when 1
    packet[:packets].map { |sub_packet| evaluate(sub_packet) }.inject(&:*)
  when 2
    packet[:packets].map { |sub_packet| evaluate(sub_packet) }.min
  when 3
    packet[:packets].map { |sub_packet| evaluate(sub_packet) }.max
  when 4
    packet[:value]
  when 5
    evaluate(packet[:packets][0]) > evaluate(packet[:packets][1]) ? 1 : 0
  when 6
    evaluate(packet[:packets][0]) < evaluate(packet[:packets][1]) ? 1 : 0
  when 7
    evaluate(packet[:packets][0]) == evaluate(packet[:packets][1]) ? 1 : 0
  end
end

hex = File.read('input.txt').chomp
packet, _ = decode(hex2bin(hex).chars)

puts "Part 1: #{version_sum(packet)}"

result = evaluate(packet)
puts "Part 2: #{result}"
