require "minitest/autorun"

require_relative "../lib/aoc"
Dir["./test/*_test.rb"].each { |file| require file }
