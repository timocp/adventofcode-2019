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
    self.vm = Intcode.new(input.chomp.split(/,/).map(&:to_i))
    execute(12, 2)
  end

  def part2
    initial_state = input.chomp.split(/,/).map(&:to_i)
    0.upto(99).each do |noun|
      0.upto(99).each do |verb|
        self.vm = Intcode.new(initial_state.dup)
        return noun * 100 + verb if execute(noun, verb) == 19690720
      end
    end
    raise "Solution not found"
  end
end
