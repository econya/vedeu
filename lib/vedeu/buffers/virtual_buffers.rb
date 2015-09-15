module Vedeu

  # Store and retrieve {Vedeu::VirtualBuffer} objects.
  #
  # Each {Vedeu::VirtualBuffer} object is a copy of the current terminal
  # including content but not as String objects but {Vedeu::Views::Char}
  # objects. Using {Vedeu::Views::Char} objects means that we can store the data
  # used to make up the displayed character, complete with its colour, position
  # and style.
  #
  # Once a {Vedeu::Views::Char} has been converted to a String, it is tricky to
  # separate the escape sequences and string data. By deferring this conversion
  # we can display the {Vedeu::Views::Char} in multiple ways (e.g. HTML) or in
  # multiple formats (e.g. JSON), and render/use that in an appropriate way.
  #
  module VirtualBuffers

    extend self

    # Fetch the oldest stored virtual buffer first.
    #
    # @return [Array<Array<Vedeu::Views::Char>>|NilClass]
    def retrieve
      Vedeu.log(type: :drb, message: 'Retrieving output')

      storage.retrieve
    end

    # Store a new virtual buffer.
    #
    # @return [Array<Array<Vedeu::Views::Char>>]
    def store(data)
      Vedeu.log(type: :drb, message: 'Storing output')

      storage.store(data)
    end

    # Return the number of virtual buffers currently stored.
    #
    # @return [Fixnum]
    def size
      storage.size
    end

    # Destroy all virtual buffers currently stored.
    #
    # @return [Vedeu::Fifo]
    def clear
      @storage = in_memory
    end
    alias_method :reset, :clear

    private

    # Access to the storage for this repository.
    #
    # @return [Vedeu::Fifo]
    def storage
      @storage ||= in_memory
    end

    # Returns an empty collection ready for the storing of virtual buffers.
    #
    # @return [Vedeu::Fifo]
    def in_memory
      Vedeu::Fifo.new([])
    end

  end # VirtualBuffers

end # Vedeu
