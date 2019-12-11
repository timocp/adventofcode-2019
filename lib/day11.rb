require "intcode"

class Day11 < Base
  class Robot
    Point = Struct.new(:x, :y)
    TURN_LEFT = { up: :left, right: :up, down: :right, left: :down }.freeze
    TURN_RIGHT = { up: :right, right: :down, down: :left, left: :up }.freeze
    DELTA = {
      up: Point.new(1, 0), right: Point.new(0, 1), down: Point.new(-1, 0), left: Point.new(0, -1)
    }.freeze
    SHIP = { up: "^", right: ">", down: "v", left: "<" }.freeze

    def initialize
      @pos = Point.new(0, 0)
      @facing = :left     # should be up but i have some kind of axis off
      @hull = Hash.new(0) # key by Point -> 0 = black, 1 = white
    end

    def execute(program, start_white: false)
      vm = Intcode.new(program)
      @hull[@pos] = 1 if start_white
      until vm.terminated
        commands = vm.run(input: [@hull[@pos]])
        commands.each_cons(2) do |cmd_colour, cmd_dir|
          @hull[@pos] = cmd_colour
          case cmd_dir
          when 0 then turn_left
          when 1 then turn_right
          end
          move_forward
        end
      end
    end

    def panels_painted
      @hull.size
    end

    def hull_to_s
      minx, maxx = ([@pos.x] + @hull.keys.map(&:x)).minmax
      miny, maxy = ([@pos.y] + @hull.keys.map(&:y)).minmax
      s = ""
      miny.upto(maxy) do |y|
        minx.upto(maxx) do |x|
          s << if @pos.x == x && @pos.y == y
                 SHIP[@facing]
               else
                 @hull[Point.new(x, y)] == 1 ? "#" : " "
               end
        end
        s += "\n"
      end
      s
    end

    private

    def turn_left
      @facing = TURN_LEFT[@facing]
    end

    def turn_right
      @facing = TURN_RIGHT[@facing]
    end

    def move_forward
      @pos = Point.new(@pos.x + DELTA[@facing].x, @pos.y + DELTA[@facing].y)
    end
  end

  def part1
    robot = Robot.new
    robot.execute(input)
    robot.panels_painted
  end

  def part2
    robot = Robot.new
    robot.execute(input, start_white: true)
    robot.hull_to_s
  end

  private

  def input
    raw_input.split(",").map(&:to_i)
  end
end
