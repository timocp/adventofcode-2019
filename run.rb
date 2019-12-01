#! /usr/bin/env ruby

require "./lib/aoc"

ARGV.each do |day|
  day = Aoc.handler(day)
  puts "Day #{day.number} part 1: #{day.part1}"
  puts "Day #{day.number} part 2: #{day.part2}" if day.respond_to?(:part2)
end
