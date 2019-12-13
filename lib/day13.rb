require "intcode"

class Day13 < Base
  class Screen
    def initialize
      @screen = Hash.new(0)
    end

    def draw(x, y, tile_id)
      @screen[[x, y]] = tile_id
    end

    def inspect
      s = ""
      0.upto(@screen.keys.map(&:last).max) do |y|
        0.upto(@screen.keys.map(&:first).max) do |x|
          s += case @screen[[x, y]]
               when 0 then " "
               when 1 then "#"
               when 2 then "B"
               when 3 then "_"
               when 4 then "o"
               end
        end
        s += "\n"
      end
      s
    end
  end

  def part1
    screen = Screen.new
    vm = Intcode.new(program)
    vm.run.each_slice(3) do |x, y, tile_id|
      screen.draw(x, y, tile_id)
    end
    screen.inspect.count("B")
  end

  def program
    raw_input.split(",").map(&:to_i)
  end
end
