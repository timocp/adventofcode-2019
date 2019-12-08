class Day8 < Base
  class Pic
    def initialize(sif, width:, height:)
      @sif = sif.chomp.each_char.map(&:to_i)
      @width = width
      @height = height
      @lsize = @width * @height
    end

    attr_reader :sif, :width, :height, :lsize

    def layer(n)
      sif[n * lsize, lsize].each_slice(width).to_a
    end

    def each_layer
      return to_enum(__method__) unless block_given?

      sif.each_slice(lsize) do |layer|
        yield layer.each_slice(width).to_a
      end
    end
  end

  def part1
    pic = Pic.new(raw_input, width: 25, height: 6)
    counts = pic.each_layer.map do |layer|
      layer.flatten.group_by(&:itself).map { |k, v| [k, v.size] }.to_h
    end
    layer = counts.min_by { |stats| stats[0] }
    layer[1] * layer[2]
  end
end
