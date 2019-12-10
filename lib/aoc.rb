require "pry"

$LOAD_PATH << File.dirname(__FILE__)
require "base"

class Aoc
  def self.handler(day)
    require "day#{day}"
    Object.const_get("Day#{day}").new.tap(&:load_input)
  end

  def self.days
    Dir.entries("input")
       .reject { |f| f.start_with?(".") }
       .map { |f| f.match(/(\d+)/)[1] }
       .map(&:to_i)
       .sort
  end
end
