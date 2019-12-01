class Base
  def load_input
    @input = File.read("input/day#{number}.txt")
  end

  def number
    self.class.name.match(/\d+$/)[0]
  end

  attr_reader :input
end
