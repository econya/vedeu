require 'drb'

module Vedeu

  module Distributed

    # @example
    #   client = Vedeu::Distributed::Client.new("druby://localhost:21420")
    #   client.input('a')
    #   client.output # => 'some content...'
    #   client.stop
    #
    class Client

      # @param uri [String]
      # @return [Client]
      def initialize(uri)
        @uri = uri.to_s
      end

      # @param data [String|Symbol]
      # @return []
      def input(data)
        server.input(data)
      end
      alias_method :read, :input

      # @return []
      def output
        server.output
      end
      alias_method :write, :output

      # @return []
      def start
        # client should be able to start a server, but what if one already
        # exists?
      end

      # @return []
      def stop
        server.stop
      end

      private

      attr_reader :uri

      # @return []
      def server
        @server ||= DRbObject.new_with_uri(uri)
      end

    end # Client

  end # Distributed

end # Vedeu