module Vedeu

  module Runtime

    # Provides the mechanism to start up a generated application.
    #
    # This class loads all necessary client application files and
    # initializes Vedeu with this data, then starts the client
    # application.
    #
    class Bootstrap

      # @param (see #initialize)
      # @return [void]
      def self.start(argv = ARGV)
        new(argv).start
      end

      # Returns a new instance of Vedeu::Runtime::Bootstrap.
      #
      # @param argv [Array<String>]
      # @return [Vedeu::Runtime::Bootstrap]
      def initialize(argv)
        @argv = argv
      end

      # Loads all of the client application files so that Vedeu has
      # access to them, then launches the client application.
      #
      # @return [void]
      def start
        configure_log!
        client_configuration!
        client_application!
        client_initialize!

        Vedeu::Launcher.execute!(argv)
      end

      protected

      # @!attribute [r] argv
      # @return [Array<String>]
      attr_reader :argv

      private

      # @return [String]
      def base_path
        Vedeu::Configuration.base_path
      end

      # @note
      #   config/configuration.rb is already loaded so don't load it
      #   twice.
      # @return [void]
      def client_configuration!
        Dir[File.join(base_path, 'config/**/*')].each do |path|
          next if path =~ %r{config/configuration\.rb}

          load(path)
        end
      end

      # @return [void]
      def client_application!
        [
          'app/views/templates/**/*'.freeze,
          'app/views/interfaces/**/*'.freeze,
          'app/controllers/**/*'.freeze,
          'app/helpers/**/*'.freeze,
          'app/views/**/*'.freeze,
          'app/models/keymaps/**/*'.freeze,
        ].each { |path| load(File.join(base_path, path)) }
      end

      # @return [void]
      def client_initialize!
        if Vedeu::Configuration.root
          Vedeu.trigger(:_goto_, *Vedeu::Configuration.root)

        else
          Vedeu.log_stderr(type: :debug, message: client_initialize_error)

        end
      end

      # Load each of the loadable files.
      #
      # @param path [String]
      # @return [String]
      def load(path)
        loadables(path).each { |file| Kernel.load(file) }

        path
      end

      # Collect each of the files from the client application
      # directories by path excluding '.' and '..' and only loading
      # files with the '.rb' extension.
      #
      # @param path [String]
      # @return [Array<String>]
      def loadables(path)
        Dir.glob(path).select do |file|
          File.file?(file) && File.extname(file) == '.rb'.freeze
        end
      end

      # @return [void]
      def configure_log!
        Vedeu.configure do
          log('/tmp/vedeu_bootstrap.log')
        end unless Vedeu::Configuration.log?
      end

      # @return [String]
      def client_initialize_error
        "Please update the 'root' setting in " \
        "'config/configuration.rb' to start Vedeu using this " \
        "controller and action: (args are optional)\n\n" \
        "Vedeu.configure do\n" \
        "  root :some_controller, :show, *args\n" \
        "end\n\n".freeze
      end

    end # Bootstrap

  end # Runtime

end # Vedeu
