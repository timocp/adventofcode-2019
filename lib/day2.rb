class Day2 < Base
  attr_accessor :vm

  def run
    pos = 0
    loop do
      case vm[pos]
      when 1 then vm[vm[pos + 3]] = vm[vm[pos + 1]] + vm[vm[pos + 2]]
      when 2 then vm[vm[pos + 3]] = vm[vm[pos + 1]] * vm[vm[pos + 2]]
      when 99 then return
      else raise "Unexpected opcode at #{pos}: #{vm[pos]}"
      end
      pos += 4
    end
  end

  def part1
    self.vm = input.chomp.split(/,/).map(&:to_i)
    vm[1] = 12
    vm[2] = 2
    run
    vm[0]
  end

  def part2
    initial_state = input.chomp.split(/,/).map(&:to_i)
    0.upto(99).each do |noun|
      0.upto(99).each do |verb|
        self.vm = initial_state.dup
        vm[1] = noun
        vm[2] = verb
        run
        return noun * 100 + verb if vm[0] == 19690720
      end
    end
    raise "Solution not found"
  end
end
