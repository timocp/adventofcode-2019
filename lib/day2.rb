require "intcode"

class Day2 < Base
  attr_accessor :vm

  def execute(noun, verb)
    vm.mem[1] = noun
    vm.mem[2] = verb
    vm.run
    vm.mem[0]
  end

  def part1
    self.vm = Intcode.new(input.dup)
    execute(12, 2)
  end

  def part2
    0.upto(99).each do |noun|
      0.upto(99).each do |verb|
        self.vm = Intcode.new(input.dup)
        return noun * 100 + verb if execute(noun, verb) == 19690720
      end
    end
    raise "Solution not found"
  end

  def input
    @input ||= raw_input.chomp.split(",").map(&:to_i).freeze
  end
end
