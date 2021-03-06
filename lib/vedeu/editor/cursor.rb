module Vedeu

  module Editor

    # Maintains a cursor position within the {Vedeu::Editor::Document}
    # class.
    #
    class Cursor

      extend Forwardable

      def_delegators :border,
                     :bx,
                     :bxn,
                     :by,
                     :byn

      # @!attribute [r] name
      # @return [String|Symbol]
      attr_reader :name

      # @!attribute [rw] ox
      # @return [Fixnum]
      attr_accessor :ox

      # @!attribute [rw] oy
      # @return [Fixnum]
      attr_accessor :oy

      # @!attribute [rw] x
      # @return [Fixnum]
      attr_writer :x

      # @!attribute [rw] y
      # @return [Fixnum]
      attr_writer :y

      # Returns a new instance of Vedeu::Editor::Cursor.
      #
      # @param attributes [Hash]
      # @option attributes y [Fixnum] The current line.
      # @option attributes x [Fixnum] The current character with the
      #   line.
      # @option attributes name [String|Symbol]
      # @option attributes oy [Fixnum]
      # @option attributes ox [Fixnum]
      # @return [Vedeu::Editor::Cursor]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Move the virtual cursor to the beginning of the line.
      #
      # @return [Vedeu::Editor::Cursor]
      def bol
        @ox = 0
        @x  = 0

        self
      end

      # Move the virtual cursor down by one line.
      #
      # @return [Vedeu::Editor::Cursor]
      def down
        @y += 1

        self
      end

      # Move the virtual cursor to the left.
      #
      # @return [Vedeu::Editor::Cursor]
      def left
        @ox -= 1 unless @ox == 0
        @x -= 1

        self
      end

      # Overwrite the cursor of the same name. This ensure that on
      # refresh the cursor stays in the correct position for the
      # document being edited.
      #
      # @return [Vedeu::Editor::Cursor]
      # @todo GL 2015-10-02 Should ox/oy be 0; or set to @ox/@oy?
      def refresh
        Vedeu::Cursors::Cursor.store(name:    name,
                                     x:       real_x,
                                     y:       real_y,
                                     ox:      0,
                                     oy:      0,
                                     visible: true)

        Vedeu.trigger(:_refresh_cursor_, name)

        self
      end

      # Move the virtual cursor to the origin (0, 0).
      #
      # @return [Vedeu::Editor::Cursor]
      def reset!
        @x  = 0
        @y  = 0
        @ox = 0
        @oy = 0

        self
      end

      # Move the virtual cursor to the right.
      #
      # @return [Vedeu::Editor::Cursor]
      def right
        @x += 1

        self
      end

      # Return the escape sequence as a string for setting the cursor
      # position and show the cursor.
      #
      # @return [String]
      def to_s
        "\e[#{real_y};#{real_x}H\e[?25h".freeze
      end

      # Move the virtual cursor up by one line.
      #
      # @return [Vedeu::Editor::Cursor]
      def up
        @oy -= 1 unless @oy == 0
        @y -= 1

        self
      end

      # @return [Fixnum] The column/character coordinate.
      def x
        @x  = 0               if @x <= 0
        @ox = @x - (bxn - bx) if @x > bxn - bx

        @x
      end

      # @return [Fixnum] The row/line coordinate.
      def y
        @y  = 0               if @y <= 0
        @oy = @y - (byn - by) if @y > byn - by

        @y
      end

      private

      # @return [Vedeu::Borders::Border]
      def border
        @border ||= Vedeu.borders.by_name(name)
      end

      # Returns the default options/attributes for this class.
      #
      # @return [Hash<Symbol => Fixnum|NilClass|String|Symbol>]
      def defaults
        {
          name: '',
          ox:   0,
          oy:   0,
          x:    0,
          y:    0,
        }
      end

      # Return the real y coordinate.
      #
      # @return [Fixnum]
      def real_y
        (by + y) - oy
      end

      # Return the real x coordinate.
      #
      # @return [Fixnum]
      def real_x
        (bx + x) - ox
      end

    end # Cursor

  end # Editor

end # Vedeu
