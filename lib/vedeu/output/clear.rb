module Vedeu

  # Clears the area defined by an interface.
  #
  class Clear

    class << self

      # Clears the area defined by the interface.
      #
      # @return [Array|String]
      # @see #initialize
      def clear(interface)
        new(interface).write
      end
      alias_method :render, :clear

    end

    # Return a new instance of Vedeu::Clear.
    #
    # @param interface [Interface]
    # @return [Vedeu::Clear]
    def initialize(interface)
      @interface = interface
    end

    # For each visible line of the interface, set the foreground and background
    # colours to those specified when the interface was defined, then starting
    # write space characters over the area which the interface occupies.
    #
    # @return [Array<Array<Vedeu::Char>>]
    def clear
      @clear ||= Array.new(interface.border.height) do |iy|
        Array.new(interface.border.width) do |ix|
          Vedeu::Char.new({ value:    ' ',
                            colour:   interface.colour,
                            style:    interface.style,
                            position: position(iy, ix) })
        end
      end
    end

    # Clear the view and send to the terminal.
    #
    # @return [Array]
    def write
      Vedeu.log(type: :output, message: "Clearing: '#{interface.name}'")

      if Vedeu::Configuration.drb?
        Vedeu.trigger(:_drb_store_output_, clear)

        Vedeu::HTMLRenderer.to_file(Vedeu::VirtualBuffer.retrieve)
      end

      # Vedeu::FileRenderer.render(clear)

      Vedeu::TerminalRenderer.render(clear)
    end

    private

    # @!attribute [r] interface
    # @return [Interface]
    attr_reader :interface

    # @param iy [Fixnum]
    # @param ix [Fixnum]
    # @return [Vedeu::IndexPosition]
    def position(iy, ix)
      Vedeu::IndexPosition[iy, ix, interface.border.by, interface.border.bx]
    end

  end # Clear

end # Vedeu
