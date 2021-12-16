def find_paths(graph, small_cave_limit:)
  stack = [['start']]
  paths = []
  until stack.empty?
    path = stack.pop
    graph[path.last].reject do |destination|
      destination == 'start'
    end.each do |destination|
      if destination == 'end'
        paths << path + [destination]
      elsif destination.downcase == destination && path.include?(destination)
        small_cave_seen_counts = path.group_by(&:itself).map do |name, group|
          [name, group.count]
        end.to_h.select do |name, _|
          name.downcase == name
        end
        if small_cave_seen_counts.all? { |_, count| count < small_cave_limit }
          stack << path + [destination]
        end
      else
        stack << path + [destination]
      end
    end
  end
  paths
end

graph = Hash.new do |h, k|
  h[k] = []
end
File.read('input.txt').lines.map(&:chomp).each do |line|
  f, t = line.split('-')
  graph[f] << t
  graph[t] << f
end

paths = find_paths(graph, small_cave_limit: 1)
puts "Part 1: #{paths.count}"

paths = find_paths(graph, small_cave_limit: 2)
puts "Part 2: #{paths.count}"
