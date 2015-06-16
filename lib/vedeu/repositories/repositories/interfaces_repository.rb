module Vedeu

  # Allows the storing of interfaces and views.
  class InterfacesRepository < Repository

    class << self

      # @return [Vedeu::InterfacesRepository]
      alias_method :interfaces, :repository

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::InterfacesRepository]
      def reset!
        @interfaces = register(Vedeu::Interface)
      end

    end

    null Vedeu::Null::Interface
    # real Vedeu::Interface

    # Returns the interfaces in zindex order.
    #
    # @return [Array<Vedeu::Interface>]
    # @see Vedeu::DSL::Interface#zindex
    def zindexed
      all.sort { |a, b| a.zindex <=> b.zindex }
    end

  end # InterfacesRepository

end # Vedeu