require "set"

class Day3 < Base
  Point = Struct.new(:x, :y) do
    def step(dir)
      case dir
      when "U" then Point.new(x, y + 1)
      when "R" then Point.new(x + 1, y)
      when "D" then Point.new(x, y - 1)
      when "L" then Point.new(x - 1, y)
      end
    end

    def manhattan_distance
      x.abs + y.abs
    end

    def origin?
      x == 0 && y == 0
    end
  end

  # represents the path of a wire through the grid
  class Wire
    def initialize(path)
      @pos = Point.new(0, 0)
      @seen = Set[@pos]
      parse(path)
    end

    attr_reader :seen

    def closest_intersection(other)
      intersections(other).reject(&:origin?).map(&:manhattan_distance).min
    end

    private

    def parse(input)
      input.split(",").each do |move|
        move.slice(1..).to_i.times do
          @pos = @pos.step(move.slice(0))
          @seen.add(@pos)
        end
      end
    end

    def intersections(other)
      (seen & other.seen).to_a
    end
  end

  def part1
    paths = input.split("\n")
    Wire.new(paths[0]).closest_intersection(Wire.new(paths[1]))
  end
end
