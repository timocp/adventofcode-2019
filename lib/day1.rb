class Day1 < Base
  def fuel_required(mass:)
    mass / 3 - 2
  end

  def part1
    input.each_line.map { |line| fuel_required(mass: line.chomp.to_i) }.inject(:+)
  end
end
