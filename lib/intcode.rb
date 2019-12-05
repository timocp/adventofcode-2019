class Intcode
  def initialize(mem, input: [], debug: false)
    @mem = mem
    @pos = 0
    @input = input
    @output = []
    @debug = debug
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
    when 5 then jump_if_true
    when 6 then jump_if_false
    when 7 then less_than
    when 8 then equals
    when 99
      return false
    else
      raise "Invalid opcode: #{opcode} at #{pos}"
    end
    puts mem.inspect if @debug
    true
  end

  def add
    debug("ADD", 4)
    mem[mem[pos + 3]] = read(1) + read(2)
    @pos += 4
  end

  def multiply
    debug("MUL", 4)
    mem[mem[pos + 3]] = read(1) * read(2)
    @pos += 4
  end

  def input
    debug("INP", 2)
    mem[mem[pos + 1]] = @input.shift
    @pos += 2
  end

  def output
    debug("OUT", 2)
    @output << read(1)
    @pos += 2
  end

  def jump_if_true
    debug("JIT", 3)
    if read(1) != 0
      @pos = read(2)
    else
      @pos += 3
    end
  end

  def jump_if_false
    debug("JIF", 3)
    if read(1) == 0
      @pos = read(2)
    else
      @pos += 3
    end
  end

  def less_than
    debug("LT", 4)
    mem[mem[pos + 3]] = read(1) < read(2) ? 1 : 0
    @pos += 4
  end

  def equals
    debug("EQ", 4)
    mem[mem[pos + 3]] = read(1) == read(2) ? 1 : 0
    @pos += 4
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

  def debug(op, num)
    return unless @debug

    print "[#{pos}]\t#{op}\t#{mem[pos]}\t"
    2.upto(num) do |param|
      print "#{mem[pos + param - 1]} "
      if mode(param) == 1
        print "i"
      else
        print "p(#{mem[mem[pos + param - 1]]})"
      end
      print "\t"
    end
    puts
  end

  private

  def current
    mem[pos]
  end
end
