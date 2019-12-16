require "aoc"
require "day16"
require "minitest/autorun"

class Day16Test < Minitest::Test
  def test_phase
    d = Day16.new
    signal = [1, 2, 3, 4, 5, 6, 7, 8]
    [
      [4, 8, 2, 2, 6, 1, 5, 8],
      [3, 4, 0, 4, 0, 4, 3, 8],
      [0, 3, 4, 1, 5, 5, 1, 8],
      [0, 1, 0, 2, 9, 4, 9, 8]
    ].each do |expected|
      signal = d.phase(signal)
      assert_equal expected, signal
    end

    [
      %w[80871224585914546619083218645595 24176176],
      %w[19617804207202209144916044189917 73745418],
      %w[69317163492948606335995924319873 52432133]
    ].each do |input, expected|
      signal = input.split("").map(&:to_i)
      100.times { signal = d.phase(signal) }
      assert_equal expected, signal.join[0, 8]
    end
  end
end
