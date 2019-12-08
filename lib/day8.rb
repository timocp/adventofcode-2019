class Day8 < Base
  class Pic
    def initialize(sif, width:, height:)
      @sif = sif.chomp.each_char.map(&:to_i)
      @width = width
      @height = height
      @lsize = @width * @height
    end

    attr_reader :sif, :width, :height, :lsize

    def each_layer
      return to_enum(__method__) unless block_given?

      sif.each_slice(lsize) { |layer| yield layer }
    end

    def pixel(x, y)
      0.upto(sif.size / lsize) do |z|
        v = sif[z * lsize + x + y * width]
        return " " if v == 0
        return "#" if v == 1
      end
      raise "no colour at (#{x}, #{y})"
    end

    def to_s
      s = ""
      0.upto(height - 1) do |y|
        0.upto(width - 1) do |x|
          s << pixel(x, y)
        end
        s += "\n"
      end
      s
    end
  end

  def part1
    layer = input_pic.each_layer.min_by { |l| l.count(0) }
    layer.count(1) * layer.count(2)
  end

  def part2
    input_pic.to_s
  end

  def input_pic
    @input_pic ||= Pic.new(raw_input, width: 25, height: 6)
  end
end
