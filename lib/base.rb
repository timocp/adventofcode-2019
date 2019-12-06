class Base
  def load_input
    @raw_input = File.read("input/day#{number}.txt")
  end

  def number
    self.class.name.match(/\d+$/)[0]
  end

  attr_reader :raw_input
end
