require "intcode"

class Day7 < Base
  def part1
    max = 0
    (0..4).to_a.permutation(5).each do |a, b, c, d, e|
      out1 = Intcode.new(program.dup, input: [a, 0]).run.last
      out2 = Intcode.new(program.dup, input: [b, out1]).run.last
      out3 = Intcode.new(program.dup, input: [c, out2]).run.last
      out4 = Intcode.new(program.dup, input: [d, out3]).run.last
      out5 = Intcode.new(program.dup, input: [e, out4]).run.last
      if out5 > max
        max = out5
      end
    end
    max
  end

  def program
    raw_input.split(",").map(&:to_i)
  end
end
