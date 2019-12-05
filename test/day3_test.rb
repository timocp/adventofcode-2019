require "day3"

class Day3Test < Minitest::Test
  WIRE = [
    Day3::Wire.new("R8,U5,L5,D3"),
    Day3::Wire.new("U7,R6,D4,L4"),
    Day3::Wire.new("R75,D30,R83,U83,L12,D49,R71,U7,L72"),
    Day3::Wire.new("U62,R66,U55,R34,D71,R55,D58,R83"),
    Day3::Wire.new("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51"),
    Day3::Wire.new("U98,R91,D20,R16,D67,R40,U7,R15,U6,R7")
  ].freeze

  def test_shortest_distance_to_intersection
    assert_equal 6, WIRE[0].closest_intersection(WIRE[1])
    assert_equal 159, WIRE[2].closest_intersection(WIRE[3])
    assert_equal 135, WIRE[4].closest_intersection(WIRE[5])
  end

  def test_fewest_steps_to_intersection
    assert_equal 30, WIRE[0].fewest_steps_to_intersection(WIRE[1])
    assert_equal 610, WIRE[2].fewest_steps_to_intersection(WIRE[3])
    assert_equal 410, WIRE[4].fewest_steps_to_intersection(WIRE[5])
  end
end
