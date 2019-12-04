class Day4 < Base
  def valid?(password)
    return false if password.size != 6

    has_double = false
    password.chars.each_cons(2) do |a, b|
      has_double = true if a == b
      return false if b < a
    end
    has_double
  end

  def part1
    start, finish = input.chomp.split("-")
    (start..finish).count { |password| valid?(password) }
  end
end
