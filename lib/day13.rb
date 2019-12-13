require "intcode"

class Day13 < Base
  class Screen
    def initialize
      @screen = Hash.new(0)
      @score = 0
      @paddle = nil
      @ball = nil
    end

    attr_reader :score, :paddle, :ball

    def draw(x, y, tile_id)
      if x == -1
        @score = tile_id
      else
        @screen[[x, y]] = tile_id
        @paddle = x if tile_id == 3
        @ball = x if tile_id == 4
      end
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
      s + "P1 #{@score}\n"
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

  def part2
    screen = Screen.new
    vm = Intcode.new(program.tap { |p| p[0] = 2 })
    until vm.terminated
      input = []
      input << (screen.ball <=> screen.paddle) if screen.ball
      vm.run(input: input).each_slice(3) do |x, y, tile_id|
        screen.draw(x, y, tile_id)
      end
      # puts screen.inspect # uncomment to watch game
    end
    screen.score
  end

  def program
    raw_input.split(",").map(&:to_i)
  end
end
