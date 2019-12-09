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
      [[3, 0, 4, 0, 99], [88], [88]],
      # program to test input equals 8
      [[3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8], [7], [0]],
      [[3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8], [8], [1]],
      [[3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8], [9], [0]],
      # same but using immediate mode
      [[3, 3, 1108, -1, 8, 3, 4, 3, 99], [7], [0]],
      [[3, 3, 1108, -1, 8, 3, 4, 3, 99], [8], [1]],
      [[3, 3, 1108, -1, 8, 3, 4, 3, 99], [9], [0]],
      # program to test input is less than 8
      [[3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8], [7], [1]],
      [[3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8], [8], [0]],
      [[3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8], [9], [0]],
      # same but using immediate mode
      [[3, 3, 1107, -1, 8, 3, 4, 3, 99], [7], [1]],
      [[3, 3, 1107, -1, 8, 3, 4, 3, 99], [8], [0]],
      [[3, 3, 1107, -1, 8, 3, 4, 3, 99], [9], [0]],
      # jump tests, output 0 if the input was 0
      [[3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9], [0], [0]],
      [[3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9], [10], [1]],
      # same, using immediate mode
      [[3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1], [0], [0]],
      [[3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1], [10], [1]]
    ].each do |program, input, expected_output|
      assert_equal expected_output, Intcode.new(program, input: input).run
    end
  end

  def test_larger
    program = "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31," \
              "1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104," \
              "999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99".split(",").map(&:to_i)
    assert_equal [999], Intcode.new(program, input: [7]).run
    assert_equal [1000], Intcode.new(program, input: [8]).run
    assert_equal [1001], Intcode.new(program, input: [9]).run
  end

  # relative mode added in day 9
  def test_relative
    [
      ["109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99", [
        109, 1, 204, -1, 1001, 100, 1, 100, 1008, 100, 16, 101, 1006, 101, 0, 99
      ]],
      ["1102,34915192,34915192,7,4,7,99,0", [1219070632396864]],
      ["104,1125899906842624,99", [1125899906842624]]
    ].each do |program, expected_output|
      assert_equal expected_output, Intcode.new(program.split(",").map(&:to_i)).run
    end
  end
end
