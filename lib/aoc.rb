require "pry"

require "./lib/base"
Dir["./lib/day*.rb"].each { |file| require file }

class Aoc
  def self.handler(day)
    Object.const_get("Day#{day}").new.tap(&:load_input)
  end
end
