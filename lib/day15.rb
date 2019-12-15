require "intcode"
require "bfs"

class Day15 < Base
  NORTH = 1
  SOUTH = 2
  WEST = 3
  EAST = 4

  Pos = Struct.new(:x, :y) do
    def move(dir)
      case dir
      when NORTH then self.class.new(x, y - 1)
      when SOUTH then self.class.new(x, y + 1)
      when WEST  then self.class.new(x - 1, y)
      when EAST  then self.class.new(x + 1, y)
      end
    end

    def origin?
      x == 0 && y == 0
    end

    def inspect
      "(#{x}, #{y})"
    end
  end

  class Map
    NOTHING = 0
    WALL = 1
    OXYGEN = 2

    def initialize
      @map = { Pos.new(0, 0) => NOTHING } # assume origin is blank
    end

    # -> 0..2 or nil for unknown
    def at(pos)
      @map[pos]
    end

    def set(pos, value)
      raise "Invalid value: #{value}" unless [NOTHING, WALL, OXYGEN].include?(value)

      @map[pos] = value
    end

    def inspect(droid)
      s = ""
      Range.new(*@map.keys.map(&:y).minmax).each do |y|
        Range.new(*@map.keys.map(&:x).minmax).each do |x|
          pos = Pos.new(x, y)
          s << if droid && pos == droid
                 "D"
               elsif droid.nil? && pos.origin?
                 "O"
               else
                 case at(Pos.new(x, y))
                 when nil     then " "
                 when NOTHING then "."
                 when WALL    then "#"
                 when OXYGEN  then "*"
                 else
                   binding.pry
                 end
               end
        end
        s += "\n"
      end
      s
    end
  end

  class Explorer
    def initialize(vm:)
      @vm = vm
      @map = Map.new
      @droid = Pos.new(0, 0)
    end

    attr_reader :map

    # fills in the map by controlling the robot and checking when it bumps
    # into walls or not.
    # mapping doesn't have to be efficient.
    # 1) do a BFS for any unknown positions.
    # 2) follow the found path, try to walk into it
    # 3) record what was there (wall or empty space)
    # repeat until we can't get to any unknown spaces (means the walls block us in)
    def explore
      while (target = search_unknown)
        # puts "PATH: #{target.inspect}"
        target.each do |dir|
          output = @vm.run(input: [dir]).first
          case output
          when 0 # droid hits wall
            @map.set(@droid.move(dir), Map::WALL)
          when 1 # droid moved into an empty space
            @droid = @droid.move(dir)
            @map.set(@droid, Map::NOTHING)
          when 2 # droid moved into a space containing oxygen
            @droid = @droid.move(dir)
            @map.set(@droid, Map::OXYGEN)
          end
        end
      end
    end

    # returns a list of direction commands that will navigate to the closest
    # unknown position
    def search_unknown
      BFS.search(UnknownFinder.new(@droid, @map))
    end

    def shortest_path_to_oxygen
      BFS.search(OxygenFinder.new(Pos.new(0, 0), @map))
    end

    class Finder
      def initialize(start_state, map)
        @start_state = start_state
        @map = map
      end

      attr_reader :start_state

      def each_successor(state, &_block)
        (1..4).each do |dir|
          succ = state.move(dir)
          yield succ, dir if @map.at(succ) != Map::WALL
        end
      end
    end

    # BFS class for finding unknown positions
    class UnknownFinder < Finder
      def goal?(state)
        @map.at(state).nil?
      end
    end

    # BFS class for finding oxygen (assumes a completed map)
    class OxygenFinder < Finder
      def goal?(state)
        @map.at(state) == Map::OXYGEN
      end
    end
  end

  def part1
    e = Explorer.new(vm: Intcode.new(program))
    e.explore
    e.shortest_path_to_oxygen.size
  end

  def program
    raw_input.split(",").map(&:to_i)
  end
end
