module Vedeu

  # Provides a mechanism to control a running client application via
  # DRb.
  #
  module Distributed

    # Value class which provides the host and port for the DRb server
    # and client.
    #
    class Uri

      # @!attribute [r] host
      # @return [String]
      attr_reader :host

      # @!attribute [r] port
      # @return [Fixnum|String]
      attr_reader :port

      # Returns a new instance of Vedeu::Distributed::Uri.
      #
      # @param host [String] Hostname or IP address.
      # @param port [Fixnum|String]
      # @return [Vedeu::Distributed::Uri]
      def initialize(host = 'localhost', port = 21_420)
        @host = host || 'localhost'
        @port = port || 21_420
      end

      # @example
      #   'druby://localhost:21420'
      #
      # @return [String] The host and port as a single value.
      def to_s
        "druby://#{host}:#{port}".freeze
      end
      alias_method :to_str, :to_s

    end # Uri

  end # Distributed

end # Vedeu
