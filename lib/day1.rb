class Day1 < Base
  def fuel_required(mass:)
    mass / 3 - 2
  end

  def total_fuel_required(mass:)
    fuel = fuel_required(mass: mass)
    if fuel > 8 # first mass that requires positive fuel itself
      fuel + total_fuel_required(mass: fuel)
    else
      fuel
    end
  end

  def part1
    input.map { |mass| fuel_required(mass: mass) }.inject(:+)
  end

  def part2
    input.map { |mass| total_fuel_required(mass: mass) }.inject(:+)
  end

  def input
    @input ||= raw_input.each_line.map(&:chomp).map(&:to_i).freeze
  end
end
