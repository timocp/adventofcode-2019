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
  end

  # represents the path of a wire through the grid
  class Wire
    def initialize(path)
      @pos = Point.new(0, 0)
      @steps = 0
      @seen = {}
      parse(path)
    end

    attr_reader :seen

    def closest_intersection(other)
      intersections(other).map(&:manhattan_distance).min
    end

    def fewest_steps_to_intersection(other)
      seen.each_pair.map do |point, steps|
        steps + other.seen[point] if other.seen.key?(point)
      end.compact.min
    end

    private

    def parse(input)
      input.split(",").each do |move|
        move.slice(1..).to_i.times do
          @pos = @pos.step(move.slice(0))
          @steps += 1
          @seen[@pos] = @steps unless @seen.key?(@pos)
        end
      end
    end

    def intersections(other)
      (seen.keys & other.seen.keys).to_a
    end
  end

  def part1
    wire1.closest_intersection(wire2)
  end

  def part2
    wire1.fewest_steps_to_intersection(wire2)
  end

  private

  def wire1
    read_wires
    @wire1
  end

  def wire2
    read_wires
    @wire2
  end

  def read_wires
    @wire1, @wire2 = raw_input.split("\n").map { |path| Wire.new(path) } if @wire1.nil?
  end
end
