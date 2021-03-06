#!/usr/bin/env ruby

input = File.read("./inputs/day_7.txt")
crabs = input.split(",").map do |crab_position|
  crab_position.to_i
end

# honestly the average is gonna be the median fuel

sum = crabs.inject(:+)
mean_position = (sum.to_f / crabs.count).round

# puts crabs

puts "mean position: #{mean_position}"

fuel = 0
crabs.each do |crab_position|
  fuel += (crab_position - mean_position).abs
end

puts " XXXX wrong answer to part 1, total fuel: #{fuel}"

# nope its not gonna be the average

lowest_pos = 0
lowest = 0

(1..2000).each do |position|
  fuel = 0
  crabs.each do |crab_position|
    fuel += (crab_position - position).abs
  end
  if lowest == 0 || fuel < lowest
    lowest_pos = position
    lowest = fuel
  end
end

puts "at position #{lowest_pos}, fuel consumption will bottom out at #{lowest}"

# NEW FUEL CONSUMPTION ALGORITHM 
lowest_pos = 0
lowest = 0

# memoize the fuel consumption steppage
# this felt quicker than working out the equation, idk it probably involves triangles
$lookup = {}
def move_from(crab_position,position)
  delta = (crab_position - position).abs
  return $lookup[delta] if $lookup[delta]
  fuel = 0
  delta.times do |step|
    fuel += (step + 1)
  end
  $lookup[delta] = fuel
end

# now test a nice handful of deltas
(1..2000).each do |position|
  fuel = 0
  crabs.each do |crab_position|
    fuel += move_from(crab_position,position)
  end
  if lowest == 0 || fuel < lowest
    lowest_pos = position
    lowest = fuel
  end
end

puts "part 2: at position #{lowest_pos}, fuel consumption will bottom out at #{lowest}"
