module Vedeu

  module Input

    # A collection of {Vedeu::Input::Key} instances.
    #
    class Keys < Vedeu::Repositories::Collection

    end # Keys

    # A single keypress or combination of keypresses bound to a
    # specific action.
    #
    class Key

      # @!attribute [r] input
      # @return [String|Symbol] Returns the key defined.
      attr_reader :input
      alias_method :key, :input

      # Returns a new instance of Vedeu::Input::Key.
      #
      # @param input [String|Symbol]
      # @param block [Proc]
      # @raise [Vedeu::Error::RequiresBlock]
      # @return [Vedeu::Input::Key]
      def initialize(input = nil, &block)
        fail Vedeu::Error::RequiresBlock unless block_given?

        @input  = input
        @output = block
      end

      # Pressing the key will call the procedure.
      #
      # @return [|Symbol]
      def output
        @output.call
      end
      alias_method :action, :output
      alias_method :press, :output

    end # Key

  end # Input

end # Vedeu
