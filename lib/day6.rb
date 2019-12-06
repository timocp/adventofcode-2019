class Day6 < Base
  def parse(input)
    @orbits = {}
    input.split("\n").map { |line| line.split(")") }.each do |big, small|
      @orbits[small.to_sym] = big.to_sym
    end
  end

  def count_orbits
    @orbits.keys.map do |thing|
      path_to_com(thing).size
    end.inject(:+)
  end

  def transfer_orbits(from:, to:)
    path1 = path_to_com(from)
    path2 = path_to_com(to)
    path1.each_with_index do |thing, i1|
      if (i2 = path2.index(thing))
        return i1 + i2
      end
    end
    nil
  end

  def part1
    parse(raw_input)
    count_orbits
  end

  def part2
    transfer_orbits(from: :YOU, to: :SAN)
  end

  private

  def path_to_com(thing)
    path = []
    while (thing = @orbits[thing])
      path << thing
    end
    path
  end
end
