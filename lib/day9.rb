require "intcode"

class Day9 < Base
  def part1
    Intcode.new(program).run(input: [1]).first
  end

  def program
    raw_input.split(",").map(&:to_i)
  end
end
