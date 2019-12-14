class Day14 < Base
  class Recipe
    # eg "7 A, 1 B => 2 C"
    # => output: C
    # => output_count: 2
    # => input: { A => 7, B => 1 }
    def initialize(line)
      input, output = line.chomp.split(" => ")
      @input = input.split(", ").map(&:split).map(&:reverse).map { |k, v| [k.to_sym, v.to_i] }.to_h
      @output, @output_count = output.split(" ").reverse
      @output = @output.to_sym
      @output_count = @output_count.to_i
    end

    attr_reader :input, :output, :output_count
  end

  class Nanofactory
    def initialize(input)
      @inv = Hash.new(0)
      @ore_used = 0
      @recipes = {}
      input.each_line.map { |line| Recipe.new(line.chomp) }.each { |r| @recipes[r.output] = r }
    end

    attr_reader :ore_used

    def build(comp)
      if comp == :ORE
        @ore_used += 1
        @inv[comp] += 1
      else
        build_recipe(@recipes[comp])
      end
    end

    def build_recipe(recipe)
      recipe.input.each do |comp, count|
        if comp == :ORE
          @ore_used += count
        else
          build(comp) while @inv[comp] < count
          @inv[comp] -= count
        end
      end
      @inv[recipe.output] += recipe.output_count
    end
  end

  def part1
    Nanofactory.new(raw_input).tap { |f| f.build(:FUEL) }.ore_used
  end
end
