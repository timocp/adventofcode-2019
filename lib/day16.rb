class Day16 < Base
  PATTERN = [0, 1, 0, -1].freeze

  def phase(input)
    output = Array.new(input.length)
    (1..(input.length)).each do |rownum|
      new_digit = 0
      input.each.with_index(1) do |digit, colnum|
        new_digit += digit * PATTERN[(colnum / rownum) % 4]
      end
      output[rownum - 1] = new_digit.abs % 10
    end
    output
  end

  def part1
    signal = input
    100.times { signal = phase(signal) }
    signal.join[0, 8]
  end

  def input
    raw_input.split("").map(&:to_i)
  end
end
