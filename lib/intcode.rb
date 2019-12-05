class Intcode
  def initialize(mem, input: [])
    @mem = mem
    @pos = 0
    @input = input
    @output = []
  end

  attr_reader :mem, :pos

  def run
    while step
    end
    @output
  end

  def step
    case opcode
    when 1 then add
    when 2 then multiply
    when 3 then input
    when 4 then output
    when 99
      return false
    else
      raise "Invalid opcode: #{opcode} at #{pos}"
    end
    true
  end

  def add
    mem[mem[pos + 3]] = read(1) + read(2)
    @pos += 4
  end

  def multiply
    mem[mem[pos + 3]] = read(1) * read(2)
    @pos += 4
  end

  def input
    mem[mem[pos + 1]] = @input.shift
    @pos += 2
  end

  def output
    @output << mem[mem[pos + 1]]
    @pos += 2
  end

  def opcode
    current % 100
  end

  # 1 -> immediate, 0 -> position
  def mode(param)
    current.digits.reverse[-param - 2] || 0
  end

  def read(param)
    if mode(param) == 1
      mem[pos + param]
    else
      mem[mem[pos + param]]
    end
  end

  private

  def current
    mem[pos]
  end
end
