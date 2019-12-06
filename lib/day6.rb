class Day6 < Base
  def parse(input)
    @orbits = {}
    input.split("\n").map { |line| line.split(")") }.each do |big, small|
      @orbits[small.to_sym] = big.to_sym
    end
  end

  def count_orbits
    @orbits.keys.map do |thing|
      count_depth(thing)
    end.inject(:+)
  end

  def part1
    parse(raw_input)
    count_orbits
  end

  private

  def count_depth(thing)
    n = 0
    while (thing = @orbits[thing])
      n += 1
    end
    n
  end
end
