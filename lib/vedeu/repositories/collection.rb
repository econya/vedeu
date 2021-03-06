module Vedeu

  module Repositories

    # Convert an Array into an object which has some meaning in the
    # context it is being used.
    #
    class Collection

      include Enumerable

      # @!attribute [r] collection
      # @return [Array|Vedeu::Repositories::Collection]
      attr_reader :collection
      alias_method :all, :collection

      # @!attribute [rw] parent
      # @return [Fixnum]
      attr_accessor :parent

      # @!attribute [rw] name
      # @return [String|Symbol|NilClass]
      attr_accessor :name

      # @param collection [Array|Vedeu::Repositories::Collection]
      # @param parent [void]
      # @param name [String|Symbol|NilClass]
      # @return [Vedeu::Repositories::Collection]
      def self.coerce(collection = [], parent = nil, name = nil)
        if collection.is_a?(Vedeu::Repositories::Collection)
          collection

        else
          new(Array(collection), parent, name)

        end
      end

      # Returns a new instance of Vedeu::Repositories::Collection.
      #
      # @param collection [void]
      # @param parent [void]
      # @param name [String|Symbol|NilClass]
      # @return [Vedeu::Repositories::Collection]
      def initialize(collection = [], parent = nil, name = nil)
        @collection = collection
        @parent     = parent
        @name       = name
      end

      # Fetch an entry from the collection via index.
      #
      # @param value [Fixnum]
      # @return [void]
      def [](value)
        collection[value]
      end

      # Adds an entry to the collection.
      #
      # @param other [Vedeu::Repositories::Collection]
      # @return [Vedeu::Repositories::Collection]
      def add(other)
        if other.is_a?(Vedeu::Repositories::Collection)
          return self.class.coerce(other, parent, name) if empty?

        else
          self.class.new(@collection += Array(other), parent, name)

        end
      end
      alias_method :<<, :add

      # Provides iteration over the collection.
      #
      # @param block [Proc]
      # @return [Enumerator]
      def each(&block)
        collection.each(&block)
      end

      # Returns a boolean indicating whether the collection is empty.
      #
      # @return [Boolean]
      def empty?
        collection.empty?
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Repositories::Collection]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && collection == other.collection
      end
      alias_method :==, :eql?

      # Returns the size of the collection.
      #
      # @return [Fixnum]
      def size
        collection.size
      end

      # Returns the collection as a String.
      #
      # @return [String]
      def to_s
        collection.map(&:to_s).join
      end
      alias_method :to_str, :to_s

    end # Collection

  end # Repositories

end # Vedeu
