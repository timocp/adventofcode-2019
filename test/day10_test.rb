require "minitest/autorun"
require_relative "../lib/aoc"
require "day10"

class Day10Test < Minitest::Test
  def test_map
    assert_equal [3, 4, 8], Day10::Map.new(example1).best_location
    assert_equal [5, 8, 33], Day10::Map.new(example2).best_location
    assert_equal [1, 2, 35], Day10::Map.new(example3).best_location
    assert_equal [6, 3, 41], Day10::Map.new(example4).best_location
    assert_equal [11, 13, 210], Day10::Map.new(example5).best_location
  end

  def example1
    <<~MAP
      .#..#
      .....
      #####
      ....#
      ...##
    MAP
  end

  def example2
    <<~MAP
      ......#.#.
      #..#.#....
      ..#######.
      .#.#.###..
      .#..#.....
      ..#....#.#
      #..#....#.
      .##.#..###
      ##...#..#.
      .#....####
    MAP
  end

  def example3
    <<~MAP
      #.#...#.#.
      .###....#.
      .#....#...
      ##.#.#.#.#
      ....#.#.#.
      .##..###.#
      ..#...##..
      ..##....##
      ......#...
      .####.###.
    MAP
  end

  def example4
    <<~MAP
      .#..#..###
      ####.###.#
      ....###.#.
      ..###.##.#
      ##.##.#.#.
      ....###..#
      ..#.#..#.#
      #..#.#.###
      .##...##.#
      .....#.#..
    MAP
  end

  def example5
    <<~MAP
      .#..##.###...#######
      ##.############..##.
      .#.######.########.#
      .###.#######.####.#.
      #####.##.#.##.###.##
      ..#####..#.#########
      ####################
      #.####....###.#.#.##
      ##.#################
      #####.##.###..####..
      ..######..##.#######
      ####.##.####...##..#
      .#####..#.######.###
      ##...#.##########...
      #.##########.#######
      .####.#.###.###.#.##
      ....##.##.###..#####
      .#.#.###########.###
      #.#.#.#####.####.###
      ###.##.####.##.#..##
    MAP
  end
end
