require "intcode"

class Day5 < Base
  def part1
    vm = Intcode.new(input.split(",").map(&:to_i), input: [1])
    vm.run.last
  end
end
