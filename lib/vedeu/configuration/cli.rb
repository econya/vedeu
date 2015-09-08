module Vedeu

  module Config

    # The Configuration::CLI class parses command-line arguments using
    # OptionParser into options used by Vedeu to affect certain behaviours.
    #
    class CLI

      # @param (see #initialize)
      def self.configure(args = [])
        new(args).configuration
      end

      # Returns a new instance of Vedeu::Config::CLI.
      #
      # Configure Vedeu via command-line arguments. Options set here via
      # arguments override the client application configuration set via
      # {Vedeu::API#configure}.
      #
      # @param args [Array]
      # @return [Vedeu::Configuration::CLI]
      def initialize(args = [])
        @args    = args
        @options = {}
      end

      # Returns the configuration options set up by parsing the command-line
      # arguments passed to the client application.
      #
      # @return [Hash]
      def configuration
        setup!

        parser.parse!(args)

        Vedeu::Config.log(Esc.blue { '[cli]' }, options)
      end

      protected

      # @!attribute [r] args
      # @return [Array<String>]
      attr_reader :args

      # @!attribute [r] options
      # @return [Hash]
      attr_reader :options

      private

      # Setup Vedeu using CLI configuration options for the client application.
      #
      # @return [void]
      def setup!
        ([:banner] + allowed_options).each { |opt| send(opt) }
      end

      # @return [OptionParser]
      def parser
        @parser ||= OptionParser.new
      end

      # @return [Array<Symbol>]
      def allowed_options
        [
          :colour_mode,
          :cooked,
          :debug,
          :drb,
          :drb_height,
          :drb_host,
          :drb_port,
          :drb_width,
          :fake,
          :interactive,
          :log,
          :profile,
          :raw,
          :run_many,
          :run_once,
          :root,
          :standalone,
        ]
      end

      # @return [String]
      def banner
        parser.banner = "Usage: #{$PROGRAM_NAME} [options]"
      end

      # CLI arguments:
      #
      #    -C, --colour-mode
      #
      # @return [OptionParser]
      def colour_mode
        parser.on('-C', '--colour-mode [COLOURS]', Integer,
                  'Run application in either `8`, `16`, `256` or `16777216` ' \
                  'colour mode.') do |colours|
          if [8, 16, 256, 16_777_216].include?(colours)
            options[:colour_mode] = colours

          else
            options[:colour_mode] = 8

          end
        end
      end

      # CLI arguments:
      #
      #    -c, --cooked
      #
      # @return [OptionParser]
      def cooked
        parser.on('-c', '--cooked', 'Run application in cooked mode.') do
          options[:terminal_mode] = :cooked
        end
      end

      # CLI arguments:
      #
      #    -d, --debug
      #
      # @return [OptionParser]
      def debug
        parser.on('-d', '--debug', 'Run application with debugging on.') do
          options[:debug] = true
        end
      end

      # CLI arguments:
      #
      #    --drb
      #
      # @return [OptionParser]
      def drb
        parser.on('--drb', 'Run application with DRb on.') do
          options[:drb] = true
        end
      end

      # CLI arguments:
      #
      #    --drb-height
      #
      # @return [OptionParser]
      def drb_height
        parser.on('--drb-height',
                  'Set the height for fake terminal.') do |height|
          options[:drb]        = true
          options[:drb_height] = height
        end
      end

      # CLI arguments:
      #
      #    --drb-host
      #
      # @return [OptionParser]
      def drb_host
        parser.on('--drb-host',
                  'Set the hostname/IP for the DRb server.') do |hostname|
          options[:drb]      = true
          options[:drb_host] = hostname
        end
      end

      # CLI arguments:
      #
      #    --drb-port
      #
      # @return [OptionParser]
      def drb_port
        parser.on('--drb-port', 'Set the port for the DRb server.') do |port|
          options[:drb]      = true
          options[:drb_port] = port
        end
      end

      # CLI arguments:
      #
      #    --drb-width
      #
      # @return [OptionParser]
      def drb_width
        parser.on('--drb-width',
                  'Set the width for fake terminal.') do |width|
          options[:drb]       = true
          options[:drb_width] = width
        end
      end

      # CLI arguments:
      #
      #    -i, --interactive
      #
      # @return [OptionParser]
      def fake
        parser.on('-f', '--fake', 'Run application in fake mode.') do
          options[:terminal_mode] = :fake
        end
      end

      # @return [OptionParser]
      def interactive
        parser.on('-i', '--interactive',
                  'Run the application in interactive mode (default).') do
          options[:interactive] = true
        end
      end

      # CLI arguments:
      #
      #    -l, --log
      #
      # @return [OptionParser]
      def log
        parser.on('-l', '--log [FILENAME]', String,
                  'Specify the path for the log file.') do |filename|
          options[:log] = filename
        end
      end

      # CLI arguments:
      #
      #    -p, --profile
      #
      # @return [OptionParser]
      def profile
        parser.on('-p', '--profile', 'Run application with profiling on.') do
          options[:profile] = true
        end
      end

      # CLI arguments:
      #
      #    -r, --raw
      #
      # @return [OptionParser]
      def raw
        parser.on('-r', '--raw', 'Run application in raw mode (default).') do
          options[:terminal_mode] = :raw
        end
      end

      # CLI arguments:
      #
      #    -s, --root
      #
      # @return [OptionParser]
      def root
        parser.on('-s', '--root []', String,
                  'Start the application from the specified controller.') do |c|
          options[:root] = c
        end
      end

      # CLI arguments:
      #
      #    -n, --run-many
      #
      # @return [OptionParser]
      def run_many
        parser.on('-n', '--run-many',
                  'Run the application loop continuously (default).') do
          options[:once] = false
        end
      end

      # CLI arguments:
      #
      #    -1, --run-once
      #
      # @return [OptionParser]
      def run_once
        parser.on('-1', '--run-once', 'Run the application loop once.') do
          options[:once] = true
        end
      end

      # CLI arguments:
      #
      #    -I, --noninteractive, --standalone
      #
      # @return [OptionParser]
      def standalone
        parser.on('-I', '--noninteractive', '--standalone',
                  'Run the application non-interactively; ' \
                  'i.e. not requiring intervention from the user.') do
          options[:interactive] = false
        end
      end

    end # CLI

  end # Config

end # Vedeu
