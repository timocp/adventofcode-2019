#! /usr/bin/env ruby

require "./lib/aoc"

def report(title)
  print title
  t0 = Time.now
  result = yield.to_s
  time = Time.now - t0
  print result + " " * (74 - title.length - result.length) + "#{time.truncate(1)}s\n"
end

(ARGV.any? ? ARGV : Aoc.days).each do |day|
  day = Aoc.handler(day)
  report("Day #{day.number} part 1: ") { day.part1 }
  report("Day #{day.number} part 2: ") { day.part2 } if day.respond_to?(:part2)
end
