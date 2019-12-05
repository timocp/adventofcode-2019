require "aoc"
require "intcode"
require "minitest/autorun"

class IntcodeTest < Minitest::Test
  def test_instruction
    vm = Intcode.new([1002, 4, 3, 4, 33])
    assert_equal 2, vm.opcode
    assert_equal 0, vm.mode(1)
    assert_equal 1, vm.mode(2)
    assert_equal 0, vm.mode(3)
    assert_equal 33, vm.read(1)
    assert_equal 3, vm.read(2)
    assert_equal 33, vm.read(3)
  end

  def test_run
    [
      [[1, 0, 0, 0, 99], [2, 0, 0, 0, 99]],
      [[2, 3, 0, 3, 99], [2, 3, 0, 6, 99]],
      [[2, 4, 4, 5, 99, 0], [2, 4, 4, 5, 99, 9801]],
      [[1, 1, 1, 4, 99, 5, 6, 0, 99], [30, 1, 1, 4, 2, 5, 6, 0, 99]],
      [[1002, 4, 3, 4, 33], [1002, 4, 3, 4, 99]]
    ].each do |program, expected_state|
      vm = Intcode.new(program)
      vm.run
      assert_equal expected_state, vm.mem
    end
  end

  def test_input_output
    [
      [[3, 0, 4, 0, 99], [88], [88]]
    ].each do |program, input, expected_output|
      vm = Intcode.new(program, input: input)
      assert_equal expected_output, vm.run
    end
  end
end
