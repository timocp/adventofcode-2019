require "day1"

class Day1Test < Minitest::Test
  def test_fuel_required
    d1 = Day1.new
    assert_equal 2, d1.fuel_required(mass: 12)
    assert_equal 2, d1.fuel_required(mass: 14)
    assert_equal 654, d1.fuel_required(mass: 1969)
    assert_equal 33583, d1.fuel_required(mass: 100756)
  end

  def test_total_fuel_required
    d1 = Day1.new
    assert_equal 2, d1.total_fuel_required(mass: 14)
    assert_equal 966, d1.total_fuel_required(mass: 1969)
    assert_equal 50346, d1.total_fuel_required(mass: 100756)
  end
end
