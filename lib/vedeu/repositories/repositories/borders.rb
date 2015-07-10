require 'vedeu/null/border'
require 'vedeu/output/border'

module Vedeu

  # Allows the storing of interface/view borders independent of the interface
  # instance.
  #
  # @api public
  class Borders < Repository

    class << self

      alias_method :borders, :repository

      # Remove all stored models from the repository.
      #
      # @example
      #   Vedeu.borders.reset!
      #
      # @return [Vedeu::Borders]
      def reset!
        @borders = register(Vedeu::Border)
      end
      alias_method :reset, :reset!

    end # Eigenclass

    null Vedeu::Null::Border
    real Vedeu::Border

  end # Borders

end # Vedeu
