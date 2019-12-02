class Day2Test < Minitest::Test
  def test_run
    d2 = Day2.new
    [
      [[1, 0, 0, 0, 99], [2, 0, 0, 0, 99]],
      [[2, 3, 0, 3, 99], [2, 3, 0, 6, 99]],
      [[2, 4, 4, 5, 99, 0], [2, 4, 4, 5, 99, 9801]],
      [[1, 1, 1, 4, 99, 5, 6, 0, 99], [30, 1, 1, 4, 2, 5, 6, 0, 99]]
    ].each do |program, expected_state|
      d2.vm = program
      d2.run
      assert_equal expected_state, d2.vm
    end
  end
end
