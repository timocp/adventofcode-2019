class Day16 < Base
  PATTERN = [0, 1, 0, -1].freeze # not used anymore

  def phase(input)
    output = Array.new(input.length)
    (1..(input.length)).each do |rownum|
      new_digit = 0
      # the *1 digits
      index = rownum - 1
      while index < input.length
        rownum.times do
          break if index >= input.length
          new_digit += input[index]
          index += 1
        end
        index += rownum * 3
      end
      # the *(-1) digits
      index = rownum * 3 - 1
      while index < input.length
        rownum.times do
          break if index >= input.length
          new_digit -= input[index]
          index += 1
        end
        index += rownum * 3
      end
      output[rownum - 1] = new_digit.abs % 10
    end
    output
  end

  # only works if start > half the input length, because it can assume all the
  # multipliers used are 1
  def phase_fast(input, start)
    output = Array.new(input.length)
    acc = 0
    (input.length - 1).downto(start) do |rownum|
      acc += input[rownum]
      output[rownum] = acc % 10
    end
    output
  end

  def decode_real_signal(input_str)
    signal = input_str.split("").map(&:to_i) * 10000
    start = input_str[0, 7].to_i
    100.times { signal = phase_fast(signal, start) }
    signal[start, 8].join
  end

  def part1
    signal = raw_input.chomp.split("").map(&:to_i)
    100.times { signal = phase(signal) }
    signal.join[0, 8]
  end

  def part2
    decode_real_signal(raw_input.chomp)
  end
end
