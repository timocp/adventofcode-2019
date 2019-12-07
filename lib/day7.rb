require "intcode"

class Day7 < Base
  def max_amp(program)
    (0..4).to_a.permutation(5).map do |pa, pb, pc, pd, pe|
      amps = 5.times.map { Intcode.new(program.dup) }
      out0 = amps[0].run(input: [pa, 0]).last
      out1 = amps[1].run(input: [pb, out0]).last
      out2 = amps[2].run(input: [pc, out1]).last
      out3 = amps[3].run(input: [pd, out2]).last
      amps[4].run(input: [pe, out3]).last
    end.max
  end

  def max_feedback_amp(program)
    (5..9).to_a.permutation(5).map do |phase_setting|
      amps = 5.times.map { |n| Intcode.new(program.dup, input: [phase_setting[n]]) }
      pipe = [0]
      until amps[4].terminated
        amps.each do |amp|
          pipe = amp.run(input: pipe)
        end
      end
      pipe.last
    end.max
  end

  def part1
    max_amp(program)
  end

  def part2
    max_feedback_amp(program)
  end

  def program
    raw_input.split(",").map(&:to_i)
  end
end
