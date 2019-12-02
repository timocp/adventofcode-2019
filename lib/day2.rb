class Day2 < Base
  attr_accessor :vm, :pos

  def run
    self.pos = 0
    while vm[pos] != 99
      case vm[pos]
      when 1 then add
      when 2 then multiply
      else raise "Unexpected opcode at #{pos}: #{vm[pos]}"
      end
      self.pos += 4
    end
  end

  def add
    vm[vm[pos + 3]] = vm[vm[pos + 1]] + vm[vm[pos + 2]]
  end

  def multiply
    vm[vm[pos + 3]] = vm[vm[pos + 1]] * vm[vm[pos + 2]]
  end

  def execute(noun, verb)
    vm[1] = noun
    vm[2] = verb
    run
    vm[0]
  end

  def part1
    self.vm = input.chomp.split(/,/).map(&:to_i)
    execute(12, 2)
  end

  def part2
    initial_state = input.chomp.split(/,/).map(&:to_i)
    0.upto(99).each do |noun|
      0.upto(99).each do |verb|
        self.vm = initial_state.dup
        return noun * 100 + verb if execute(noun, verb) == 19690720
      end
    end
    raise "Solution not found"
  end
end
