require "aoc"
require "day12"
require "minitest/autorun"

class Day12Test < Minitest::Test
  def test_1
    system = system1
    system.step(10)
    assert_equal 179, system.total_energy
  end

  def test_2
    system = system2
    system.step(100)
    assert_equal 1940, system.total_energy
  end

  def test_repeat
    assert_equal 2772, system1.count_to_repeat
    assert_equal 4686774924, system2.count_to_repeat
  end

  def system1
    Day12::System.parse <<~SCAN
      <x=-1, y=0, z=2>
      <x=2, y=-10, z=-7>
      <x=4, y=-8, z=8>
      <x=3, y=5, z=-1>
    SCAN
  end

  def system2
    Day12::System.parse <<~SCAN
      <x=-8, y=-10, z=0>
      <x=5, y=5, z=10>
      <x=2, y=-7, z=3>
      <x=9, y=-8, z=-3>
    SCAN
  end
end
