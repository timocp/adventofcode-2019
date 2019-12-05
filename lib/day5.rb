require "intcode"

class Day5 < Base
  def part1
    Intcode.new(parse_input, input: [1]).run.last
  end

  def part2
    Intcode.new(parse_input, input: [5]).run.last
  end

  def parse_input
    input.split(",").map(&:to_i)
  end
end
