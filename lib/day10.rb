class Day10 < Base
  Asteroid = Struct.new(:number, :x, :y) do
    def to_s
      "A#{number.to_s(16)} (#{x},#{y})"
    end
  end

  class Map
    def initialize(input)
      @roids = []
      input.each_line.with_index do |line, y|
        line.strip.each_char.with_index do |char, x|
          @roids << Asteroid.new(@roids.length, x, y) if char == "#"
        end
      end
      @roids.freeze
    end

    # returns [x, y, num_visible] of best location for monitoring station.
    # for each asteroid, work out the angle of view to each other asteroid.
    # the number of unique angles is the number of visible asteroids.
    def best_location
      visible = @roids.map { [] }
      @roids.combination(2).each do |a, b|
        dy = a.y - b.y
        dx = a.x - b.x
        visible[a.number] << Math.atan2(dy, dx)
        visible[b.number] << Math.atan2(-dy, -dx)
      end
      count, best = visible.map(&:uniq).map(&:count).each_with_index.max
      [@roids[best].x, @roids[best].y, count]
    end
  end

  def part1
    Map.new(raw_input).best_location[2]
  end
end
