class Day10 < Base
  Asteroid = Struct.new(:number, :x, :y) do
    def to_xy
      [x, y]
    end
  end

  OtherAsteroid = Struct.new(:number, :angle, :distance)

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

    def best_location
      best, count = best_location_calc
      [best.x, best.y, count]
    end

    # returns an array of the asteroids in the order they are vaporised
    def vaporise
      best, _count = best_location_calc
      targets = visibility[best.number].dup
      prev_angle = nil
      doomed = []
      while targets.any?
        target = nil
        candidates = if prev_angle
                       targets.select { |oa| oa.angle > prev_angle }
                     else
                       targets
                     end
        target = candidates.min_by { |oa| [oa.angle, oa.distance] }
        if target
          prev_angle = target.angle
          doomed << target
          targets.reject! { |oa| oa.number == target.number }
        else
          # try again next cycle
          prev_angle = nil
        end
      end
      doomed.map { |oa| @roids[oa.number].to_xy }
    end

    private

    # returns [asteroid, num_visible] of best location for monitoring station.
    # for each asteroid, work out the angle of view to each other asteroid.
    # the number of unique angles is the number of visible asteroids.
    def best_location_calc
      angles = visibility.map { |oas| oas.map(&:angle) }
      count, best = angles.map(&:uniq).map(&:count).each_with_index.max
      [@roids[best], count]
    end

    def visibility
      @visibility ||= calc_visibility
    end

    # calculate the visibility from each asteroid.
    # returns an array with an element for each asteroid
    # each element is an array of OtherAsteroid
    def calc_visibility
      visible = @roids.map { [] }
      @roids.combination(2).each do |a, b|
        dy = a.y - b.y
        dx = a.x - b.x
        distance = Math.sqrt(dy**2 + dx**2)
        visible[a.number] << OtherAsteroid.new(b.number, rad2deg(Math.atan2(dy, dx)), distance)
        visible[b.number] << OtherAsteroid.new(a.number, rad2deg(Math.atan2(-dy, -dx)), distance)
      end
      visible.freeze
    end

    # convert to degrees and rotate left 90 (so that 0 is up)
    def rad2deg(rad)
      rad += 2 * Math::PI if rad < 0
      (rad * 360 / (2 * Math::PI) - 90) % 360
    end
  end

  def part1
    Map.new(raw_input).best_location[2]
  end

  def part2
    x, y = Map.new(raw_input).vaporise[199]
    x * 100 + y
  end
end
