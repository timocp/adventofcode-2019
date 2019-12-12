class Day12 < Base
  Moon = Struct.new(:x, :y, :z, :dx, :dy, :dz) do
    def inspect
      "pos=<x=#{x}, y=#{y}, z=#{z}>, vel=<x=#{dx}, y=#{dy}, z=#{dz}>"
    end

    def move
      self.x += dx
      self.y += dy
      self.z += dz
    end

    def total_energy
      potential_energy * kinetic_energy
    end

    def potential_energy
      x.abs + y.abs + z.abs
    end

    def kinetic_energy
      dx.abs + dy.abs + dz.abs
    end

    def statex
      [x, dx]
    end

    def statey
      [y, dy]
    end

    def statez
      [z, dz]
    end
  end

  class System
    def initialize
      @steps = 0
      @moons = []
    end

    def self.parse(input)
      System.new.tap do |system|
        input.each_line do |line|
          system.add_moon(*line.match(/x=(-?\d+), y=(-?\d+), z=(-?\d+)/)[1..3].map(&:to_i))
        end
      end
    end

    def step(count = 1)
      count.times do
        apply_gravity
        apply_velocity
        @steps += 1
      end
    end

    def apply_gravity
      @moons.combination(2) do |a, b|
        gx, gy, gz = a.x <=> b.x, a.y <=> b.y, a.z <=> b.z
        a.dx -= gx
        b.dx += gx
        a.dy -= gy
        b.dy += gy
        a.dz -= gz
        b.dz += gz
      end
    end

    def apply_velocity
      @moons.each(&:move)
    end

    def total_energy
      @moons.map(&:total_energy).inject(:+)
    end

    def add_moon(x, y, z)
      @moons << Moon.new(x, y, z, 0, 0, 0)
    end

    def inspect
      (["After #{@steps} steps:"] + @moons.map(&:inspect)).join("\n")
    end

    def count_to_repeat
      start = [@moons.map(&:statex), @moons.map(&:statey), @moons.map(&:statez)]
      repeat = [nil, nil, nil]

      until repeat.all?
        step
        repeat[0] = @steps if !repeat[0] && @moons.map(&:statex) == start[0]
        repeat[1] = @steps if !repeat[1] && @moons.map(&:statey) == start[1]
        repeat[2] = @steps if !repeat[2] && @moons.map(&:statez) == start[2]
      end
      repeat.inject(1, :lcm)
    end
  end

  def part1
    system = System.parse(raw_input)
    system.step(1000)
    system.total_energy
  end

  def part2
    System.parse(raw_input).count_to_repeat
  end
end
