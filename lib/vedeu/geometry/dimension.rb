module Vedeu

  module Geometry

    # A Dimension is either the height or width of an entity.
    #
    class Dimension

      extend Forwardable

      def_delegators :alignment,
                     :bottom_aligned?,
                     :centre_aligned?,
                     :left_aligned?,
                     :middle_aligned?,
                     :right_aligned?,
                     :top_aligned?,
                     :unaligned?

      # @param (see #initialize)
      # @return [Array<Fixnum>]
      def self.pair(attributes = {})
        new(attributes).pair
      end

      # Returns a new instance of Vedeu::Geometry::Dimension.
      #
      # @param attributes [Hash<Symbol => Fixnum, NilClass>]
      # @option attributes d [Fixnum|NilClass]
      #   The starting value (y or x).
      # @option attributes dn [Fixnum|NilClass]
      #   The ending value (yn or xn).
      # @option attributes d_dn [Fixnum|NilClass] A width or a height.
      # @option attributes default [Fixnum|NilClass]
      #   The terminal width or height.
      # @option attributes maximised [Boolean]
      # @option attributes alignment [Symbol]
      # @return [Vedeu::Geometry::Dimension]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Fetch the coordinates.
      #
      # @return [Array<Fixnum>]
      def pair
        dimension
      end

      protected

      # @!attribute [r] d
      # @return [Fixnum|NilClass] The starting value (y or x).
      attr_reader :d

      # @!attribute [r] dn
      # @return [Fixnum|NilClass] The ending value (yn or xn).
      attr_reader :dn

      # @!attribute [r] d_dn
      # @return [Fixnum|NilClass] A width or a height.
      attr_reader :d_dn

      # @!attribute [r] default
      # @return [Fixnum|NilClass] The terminal width or height.
      attr_reader :default

      # @!attribute [r] maximised
      # @return [Boolean]
      attr_reader :maximised
      alias_method :maximised?, :maximised

      private

      # @raise [Vedeu::Error::NotImplemented] Subclasses of this class
      #   must implement this method.
      def alignment
        fail Vedeu::Error::NotImplemented, 'Subclasses implement this.'.freeze
      end

      # Return the dimension.
      #
      # 1) If maximised, it will be from the first row/line or column/
      #    character to the last row/line or column/character of the
      #    terminal.
      # 2) If centred,
      #
      # @return [Array<Fixnum>]
      def dimension
        @dimension = if maximised?
                       [1, default]

                     elsif bottom_aligned? || right_aligned?
                       [start_coordinate, default]

                     elsif centre_aligned? || middle_aligned?
                       [centred_d, centred_dn]

                     elsif left_aligned? || top_aligned?
                       [1, end_coordinate]

                     else
                       [_d, _dn]

                     end
      end

      # Return a boolean indicating we know the length if a we know
      # either the terminal width or height, or we can determine a
      # length from the values provided.
      #
      # @return [Boolean]
      # @todo GL 2015-10-16 Investigate: should this be && or ||.
      def length?
        default && length
      end

      # Provide the number of rows/lines or columns/characters.
      #
      # 1) Use the starting (x or y) and ending (xn or yn) values.
      # 2) Or use the width or height value.
      # 3) Or use the default/current terminal width or height value.
      #
      # @return [Fixnum|NilClass]
      def length
        if d && dn
          (d..dn).size

        elsif d_dn
          d_dn

        else
          default

        end
      end

      # Ascertains the centred starting coordinate.
      #
      # @example
      #    default = 78 # => 39
      #    length = 24 # => 12
      #    centred_d = 27 # (39 - 12 = 27)
      #
      # @return [Fixnum]
      def centred_d
        d = (default / 2) - (length / 2)
        d < 1 ? 1 : d
      end

      # Ascertains the centred ending coordinate.
      #
      # @example
      #    default = 78 # => 39
      #    length = 24 # => 12
      #    centred_dn = 51 # (39 + 12 = 51)
      #
      # @return [Fixnum]
      def centred_dn
        dn = (default / 2) + (length / 2)
        dn > default ? default : dn
      end

      # Ascertains the ending coordinate for a left or top aligned
      # interface/view.
      #
      # 1) Use the width or height (d_dn), or
      # 2) Use the xn or yn (dn), or
      # 3) Default to the terminal width or height.
      #
      # @return [Fixnum]
      def end_coordinate
        if d_dn
          (d_dn > default) ? default : d_dn

        elsif dn
          dn

        else
          default

        end
      end

      # Ascertains the starting coordinate for a right or bottom
      # aligned interface/view.
      #
      # 1) Use the width or height (d_dn), or
      # 2) Use the x or y (d), or
      # 3) Default to 1.
      #
      # @return [Fixnum]
      def start_coordinate
        if d_dn
          (default - d_dn) < 1 ? 1 : (default - d_dn)

        elsif d
          d

        else
          1

        end
      end

      # Fetch the starting coordinate, or use 1 when not set.
      #
      # @return [Fixnum]
      def _d
        d || 1
      end

      # Fetch the ending coordinate.
      #
      # 1) if an end value was given, use that.
      # 2) if a start value wasn't given, but a width or height was,
      #    use the width or height.
      # 3) if a start value was given and a width or height was given,
      #    add the width or height to the start and minus 1.
      # 4) otherwise, use the terminal default width or height.
      #
      # @return [Fixnum]
      def _dn
        if dn
          dn

        elsif d.nil? && d_dn
          d_dn

        elsif d && d_dn
          (d + d_dn) - 1

        elsif default
          default

        else
          1

        end
      end

      # Returns the default options/attributes for this class.
      #
      # @return [Hash<Symbol => NilClass,Boolean,Symbol>]
      def defaults
        {
          d:         nil,
          dn:        nil,
          d_dn:      nil,
          maximised: false,
        }
      end

    end # Dimension

  end # Geometry

end # Vedeu
