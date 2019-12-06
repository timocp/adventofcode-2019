require "intcode"

class Day5 < Base
  def part1
    Intcode.new(program.dup, input: [1]).run.last
  end

  def part2
    Intcode.new(program.dup, input: [5]).run.last
  end

  def program
    @program ||= raw_input.split(",").map(&:to_i).freeze
  end
end
