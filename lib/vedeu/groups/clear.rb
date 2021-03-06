module Vedeu

  module Groups

    # Clear the interfaces belonging to the named group.
    #
    class Clear

      class << self

        # Clears the group of interfaces belonging to the given name.
        #
        # @example
        #   Vedeu.trigger(:_clear_group_, name)
        #   Vedeu.clear_by_group(name)
        #
        # @param name [String|Symbol]
        # @return [void]
        def render(name)
          new(name).render
        end
        alias_method :clear_by_group, :render
        alias_method :by_group, :render

      end # Eigenclass

      # Return a new instance of Vedeu::Groups::Clear.
      #
      # @param name [String|Symbol]
      # @return [Vedeu::Groups::Clear]
      def initialize(name)
        @name = name
      end

      # @return [void]
      def render
        members.each { |name| Vedeu.trigger(:_clear_view_, name) }
      end

      protected

      # @!attribute [r] name
      # @return [String|Symbol]
      attr_reader :name

      private

      # @return [Array<String>]
      def members
        Vedeu.groups.by_name(name).members
      end

    end # Clear

  end # Groups

  # @!method clear_by_group
  #   @see Vedeu::Groups::Clear.render
  def_delegators Vedeu::Groups::Clear, :clear_by_group

  # :nocov:

  # See {file:docs/events/visibility.md#\_clear_group_}
  Vedeu.bind(:_clear_group_) { |name| Vedeu.clear_by_group(name) }

  # :nocov:

end # Vedeu
