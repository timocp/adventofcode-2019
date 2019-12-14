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
      @recipes = {}
      input.each_line.map { |line| Recipe.new(line.chomp) }.each { |r| @recipes[r.output] = r }
    end

    # returns the number of ORE used to build num x component
    def build(comp, num, inv = Hash.new(0))
      recipe = @recipes[comp]
      ore_used = 0

      repeats = (num.to_r / recipe.output_count).ceil
      recipe.input.each do |recipe_mat, recipe_mat_count|
        mat_needed = recipe_mat_count * repeats
        if recipe_mat == :ORE
          ore_used += mat_needed
        elsif inv[recipe_mat] >= mat_needed
          inv[recipe_mat] -= mat_needed
        else
          ore_used += build(recipe_mat, mat_needed - inv[recipe_mat], inv)
          inv[recipe_mat] -= mat_needed
        end
      end
      inv[comp] += repeats * recipe.output_count
      ore_used
    end

    def max_fuel(units)
      f1 = build(:FUEL, 1)
      (1..units).bsearch do |i|
        build(:FUEL, i) + f1 >= units
      end
    end
  end

  def part1
    Nanofactory.new(raw_input).build(:FUEL, 1)
  end

  def part2
    Nanofactory.new(raw_input).max_fuel(1000000000000)
  end
end
