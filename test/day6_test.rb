require "minitest/autorun"
require_relative "../lib/aoc"
require "day6"

class Day6Test < Minitest::Test
  def test_count_orbits
    d = Day6.new
    d.parse("COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L\n")
    assert_equal 42, d.count_orbits
  end

  def test_transfer_orbits
    d = Day6.new
    d.parse("COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L\nK)YOU\nI)SAN\n")
    assert_equal 4, d.transfer_orbits(from: :YOU, to: :SAN)
  end
end
