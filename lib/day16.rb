class Day16 < Base
  PATTERN = [0, 1, 0, -1].freeze

  def phase(input)
    input.map.with_index(1) do |_, rownum|
      input.map.with_index(1) do |digit, colnum|
        offset = (colnum / rownum)
        digit * PATTERN[offset % 4]
      end.inject(&:+).abs % 10
    end
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
