class Intcode
  class IntcodeError < StandardError; end

  def initialize(mem, input: [], debug: false)
    @mem = mem
    @pos = 0
    @input = input
    @output = []
    @debug = debug
    @terminated = false
    @relative_base = 0
  end

  attr_reader :mem, :pos, :terminated

  def run(input: nil)
    raise_error("VM is already terminated") if @terminated

    @input += input if input
    @output = []
    while step
    end
    @output
  end

  def step
    return false if opcode == 3 && @input.none? # "pause" vm

    case opcode
    when 1 then add
    when 2 then multiply
    when 3 then input
    when 4 then output
    when 5 then jump_if_true
    when 6 then jump_if_false
    when 7 then less_than
    when 8 then equals
    when 9 then adjust_relative_base
    when 99
      @terminated = true
      return false
    else
      raise_error("Invalid opcode: #{opcode}")
    end
    puts if @debug
    true
  end

  def add
    debug("ADD", 4)
    write(3, read(1) + read(2))
    @pos += 4
  end

  def multiply
    debug("MUL", 4)
    write(3, read(1) * read(2))
    @pos += 4
  end

  def input
    debug("INP", 2)
    write(1, @input.shift)
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
    write(3, read(1) < read(2) ? 1 : 0)
    @pos += 4
  end

  def equals
    debug("EQ", 4)
    write(3, read(1) == read(2) ? 1 : 0)
    @pos += 4
  end

  def adjust_relative_base
    debug("ARB", 2)
    @relative_base += read(1)
    @pos += 2
  end

  def opcode
    current % 100
  end

  # 2 -> relative, 1 -> immediate, 0 -> position
  def mode(param)
    current.digits.reverse[-param - 2] || 0
  end

  def read(param)
    puts "READ p=#{param} m=#{mode(param)} a=#{address(param)} -> #{mem.fetch(address(param), 0)}" \
      if @debug
    raise_error("Invalid read #{address(param)}") if address(param) < 0
    mem.fetch(address(param), 0)
  end

  # write value to address given by param, which can be positional or
  # relative
  def write(param, value)
    puts "WRITE p=#{param} m=#{mode(param)} a=#{address(param)} v=#{value}" if @debug
    raise_error("Invalid write #{address(param)}") if address(param) < 0
    mem[address(param)] = value
  end

  def debug(op, num)
    return unless @debug

    print "[pos=#{pos} rb=#{relative_base}]\t#{op}\t#{mem[pos]}\t"
    2.upto(num) do |param|
      print mem[pos + param - 1]
      print "\t"
    end
    puts
  end

  private

  attr_reader :relative_base

  def current
    mem[pos]
  end

  # returns the real address that a param refers to given the mode
  def address(param)
    case mode(param)
    when 0 then mem[pos + param]                 # positional
    when 1 then pos + param                      # immediate
    when 2 then relative_base + mem[pos + param] # relative
    else
      raise_error("Invalid address: param=#{param}, mode=#{param(mode)}")
    end
  end

  def raise_error(message)
    raise IntcodeError, "at #{pos} (#{mem[pos]}): #{message}", caller
  end
end
