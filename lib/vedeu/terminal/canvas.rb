module Vedeu

  module Terminal

    class Canvas

      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      def oxn
        ox + Vedeu.width
      end

      def oyn
        oy + Vedeu.height
      end

      private

      def defaults
        {
          ox: 0,
          oy: 0,
        }
      end

    end # Canvas

  end # Terminal

end # Vedeu
