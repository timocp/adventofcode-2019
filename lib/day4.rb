class Day4 < Base
  def valid?(password, strict: false)
    return false if password.size != 6

    count = Hash.new(0)
    password.chars.each_cons(2) do |a, b|
      return false if b < a
      count[a] += 1
    end
    count[password[-1]] += 1
    if strict
      # must be at least one which was a double not part of a larger group
      count.values.detect { |c| c == 2 }
    else
      # any double is OK
      count.values.detect { |c| c > 1 }
    end
  end

  def part1
    input_to_range.count { |password| valid?(password) }
  end

  def part2
    input_to_range.count { |password| valid?(password, strict: true) }
  end

  def input_to_range
    start, finish = input.chomp.split("-")
    (start..finish)
  end
end
