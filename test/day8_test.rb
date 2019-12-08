require "minitest/autorun"
require_relative "../lib/aoc"
require "day8"

class Day8Test < Minitest::Test
  def test_decode
    pic = Day8::Pic.new("0222112222120000", width: 2, height: 2)
    assert_equal " #\n# \n", pic.to_s
  end
end
