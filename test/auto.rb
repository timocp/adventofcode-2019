require "minitest/autorun"

require "./lib/aoc"
Dir["./test/day*_test.rb"].each { |file| require file }
