module Vedeu

  module Views

    # A collection of {Vedeu::Views::View} instances.
    #
    # @api private
    class ViewCollection < Vedeu::Repositories::Collection

    end # ViewCollection

    # Represents a container for {Vedeu::Views::Line} and
    # {Vedeu::Views::Stream} objects.
    #
    class View

      include Vedeu::Repositories::Model
      include Vedeu::Presentation

      collection Vedeu::Views::Lines
      member     Vedeu::Views::Line

      # @!attribute [r] attributes
      # @return [Hash]
      attr_reader :attributes

      # @!attribute [rw] client
      # @return [Fixnum|Float]
      attr_accessor :client

      # @!attribute [rw] name
      # @return [String]
      attr_accessor :name

      # @!attribute [rw] parent
      # @return [Vedeu::Views::Composition]
      attr_accessor :parent

      # @!attribute [w] lines
      # @return [Array<Vedeu::Views::Line>]
      attr_writer :lines

      # @!attribute [rw] zindex
      # @return [Fixnum]
      attr_accessor :zindex

      # Return a new instance of Vedeu::Views::View.
      #
      # @param attributes [Hash]
      # @option attributes client [Vedeu::Client]
      # @option attributes colour [Vedeu::Colours::Colour]
      # @option attributes value [Vedeu::Views::Lines]
      # @option attributes name [String|Symbol]
      # @option attributes parent [Vedeu::Views::Composition]
      # @option attributes style [Vedeu::Presentation::Style]
      # @option attributes zindex [Fixnum]
      # @return [Vedeu::Views::View]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @param child [Vedeu::Views::Line]
      # @return [Vedeu::Views::Lines]
      def add(child)
        @value = value.add(child)
      end
      alias_method :<<, :add

      # @return [Vedeu::Views::Lines]
      def value
        collection.coerce(@value, self)
      end
      alias_method :lines, :value

      # Store the view and immediately refresh it; causing to be
      # pushed to the Terminal. Called by {Vedeu::DSL::View.renders}.
      #
      # @return [Vedeu::Views::View]
      def store_immediate
        store_deferred

        Vedeu.trigger(:_refresh_view_, name)

        self
      end

      # When a name is given, the view is stored with this name. This
      # view will be shown next time a refresh event is triggered with
      # this name. Called by {Vedeu::DSL::View.views}.
      #
      # @raise [Vedeu::Error::InvalidSyntax] The name is not defined.
      # @return [Vedeu::Views::View]
      def store_deferred
        fail Vedeu::Error::InvalidSyntax,
             'Cannot store an interface ' \
             'without a name.'.freeze unless present?(name)

        Vedeu.buffers.by_name(name).add(self)

        self
      end

      # Returns a boolean indicating whether the view is visible.
      #
      # @return [Boolean]
      def visible?
        Vedeu.interfaces.by_name(name).visible?
      end

      private

      # The default values for a new instance of this class.
      #
      # @return [Hash]
      def defaults
        {
          client: nil,
          colour: Vedeu::Colours::Colour.coerce(background: :default,
                                                foreground: :default),
          name:   '',
          parent: nil,
          style:  :normal,
          value:  [],
          zindex: 0,
        }
      end

    end # View

  end # Views

end # Vedeu
