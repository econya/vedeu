module Vedeu
  class Events

    # @param block [Proc]
    # @return [Events]
    def initialize(&block)
      @handlers = Hash.new { |hash, key| hash[key] = { events: [] } }

      instance_eval(&block) if block_given?
    end

    # @param object []
    # @param block [Proc]
    # @return []
    def add(object, &block)
      @self_before_instance_eval = eval('self', block.binding)

      instance_eval(&block)
    end

    # @see Vedeu::API#event
    def event(name, opts = {}, &block)
      handlers[name][:events] << Event.new(block, opts)
      handlers[name]
    end

    # Unregisters the event by name, effectively deleting the associated events
    # bound with it also.
    #
    # @param name [Symbol]
    # @return []
    def unevent(name)
      handlers.delete_if { |k, v| k == name }
    end

    # Returns a collection of the names of all the registered events.
    #
    # @return [Array]
    def registered
      handlers.keys
    end

    # @see Vedeu::API#trigger
    def trigger(name, *args)
      handlers[name][:events].each { |event| event.trigger(*args) }
    end

    def reset
      @handlers = Hash.new { |hash, key| hash[key] = { events: [] } }
    end

    private

    attr_reader :handlers

    def method_missing(method, *args, &block)
      @self_before_instance_eval.send(method, *args, &block)
    end

  end
end