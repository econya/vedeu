module Vedeu

  # class Cell < Struct.new(:value)
  #   def initialize(value = [])
  #     super
  #   end
  # end

  # class Cells
  #   attr_reader :size, :value

  #   def initialize(size = 0, &block)
  #     @size  = size
  #     @value = if block_given?
  #       [instance_eval(&block)] * size

  #     else
  #       [Cell.new] * size

  #     end
  #   end

  #   def [](index)
  #     value[index] || self
  #   end

  #   private

  #   attr_reader :size, :value
  # end

  class VirtualTerminal

    attr_reader :cell_height, :cell_width, :height, :width

    # @param height [Fixnum]
    # @param width [Fixnum]
    # @return [Vedeu::VirtualTerminal]
    def initialize(height, width)
      @cell_height, @cell_width = Vedeu::PositionIndex[height, width]
      @height = height
      @width  = width
    end

    # @return [Array<Vedeu::Char>]
    def cells
      Array.new(cell_height) { Array.new(cell_width) { Vedeu::Char.new } }
    end

    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Vedeu::Char]
    def read(y, x)
      cy, cx = Vedeu::PositionIndex[y, x]

      row  = fetch(cells, cy)
      cell = fetch(row, cx)

      cell
    end

    # @param y [Fixnum]
    # @param x [Fixnum]
    # @param data [Vedeu::Char]
    # @return [Vedeu::Char]
    def write(y, x, data)
      cy, cx = Vedeu::PositionIndex[y, x]

      return false unless read(y, x).is_a?(Vedeu::Char)

      cells[cy][cx] = data
      true
    end

    private

    # @param from [Array]
    # @param which [Array]
    # @return [Array<Vedeu::Char>|Array]
    def fetch(from, which)
      from[which] || []
    end

  end # VirtualTerminal

end # Vedeu
