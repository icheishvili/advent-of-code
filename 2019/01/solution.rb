def simple_fuel(mass)
  (mass / 3.0).floor.to_i - 2
end

def recursive_fuel(mass)
  required = (mass / 3.0).floor.to_i - 2
  if required > 0
    required + recursive_fuel(required)
  else
    0
  end
end

masses = File.read('input.txt').lines.map(&:to_i)

fuel_requirements = masses.map do |mass|
  simple_fuel(mass)
end

puts "Part 1: #{fuel_requirements.sum}"

fuel_requirements = masses.map do |mass|
  recursive_fuel(mass)
end

puts "Part 2: #{fuel_requirements.sum}"
