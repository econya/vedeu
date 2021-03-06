module Vedeu

  module Input

    # A container class for keys associated with a particular
    # interface.
    #
    class Keymap

      include Vedeu::Repositories::Model

      collection Vedeu::Input::Keys
      member     Vedeu::Input::Key

      # @!attribute [rw] name
      # @return [String]
      attr_accessor :name

      # Returns a new instance of Vedeu::Input::Keymap.
      #
      # @param attributes [Hash]
      # @option attributes name [String|Symbol] The name of the
      #   keymap.
      # @option attributes keys [Vedeu::Input::Keys|Array]
      #   A collection of keys.
      # @option attributes repository
      #   [Vedeu::Repositories::Repository] This model's storage.
      # @return [Vedeu::Input::Keymap]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Add a key to the keymap.
      #
      # @param key [Vedeu::Input::Key]
      # @return [void]
      def add(key)
        return false unless valid?(key)

        @keys = keys.add(key)
      end

      # Returns the collection of keys defined for this keymap.
      #
      # @return [Vedeu::Input::Keys]
      def keys
        collection.coerce(@keys, self)
      end

      # Check whether the key is already defined for this keymap.
      #
      # @param input [String|Symbol]
      # @return [Boolean] A boolean indicating the input provided is
      #   already in use for this keymap.
      def key_defined?(input)
        keys.any? { |key| key.input == input }
      end

      # When the given input is registered with this keymap, this
      # method triggers the action associated with the key.
      #
      # @param input [String|Symbol]
      # @return [Array|FalseClass]
      def use(input)
        return false unless key_defined?(input)

        Vedeu.log(type: :input, message: "Key pressed: '#{input}'".freeze)

        Vedeu.trigger(:key, input)

        keys.select { |key| key.input == input }.map(&:press)
      end

      private

      # Returns the default options/attributes for this class.
      #
      # @return [Hash]
      def defaults
        {
          name:       '',
          keys:       [],
          repository: Vedeu::Input::Keymaps.keymaps,
        }
      end

      # Checks that the provided key is not already registered with
      # this keymap.
      #
      # @param key [Vedeu::Input::Key]
      # @return [Boolean]
      def valid?(key)
        return true unless key_defined?(key.input)

        Vedeu.log(type:    :input,
                  message: "Keymap '#{name}' already " \
                           "defines '#{key.input}'.".freeze)

        false
      end

    end # Keymap

  end # Input

end # Vedeu
