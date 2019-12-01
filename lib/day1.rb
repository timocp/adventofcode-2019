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
    input.each_line.map { |line| fuel_required(mass: line.chomp.to_i) }.inject(:+)
  end

  def part2
    input.each_line.map { |line| total_fuel_required(mass: line.chomp.to_i) }.inject(:+)
  end
end
