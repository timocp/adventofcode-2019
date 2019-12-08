require "minitest/autorun"
require_relative "../lib/aoc"
require "day8"

class Day8Test < Minitest::Test
  def test_layers
    pic = Day8::Pic.new("123456789012\n", width: 3, height: 2)
    assert_equal [[1, 2, 3], [4, 5, 6]], pic.layer(0)
    assert_equal [[7, 8, 9], [0, 1, 2]], pic.layer(1)
  end

  def test_decode
    pic = Day8::Pic.new("0222112222120000", width: 2, height: 2)
    assert_equal " #\n# \n", pic.to_s
  end
end
