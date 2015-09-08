#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'vedeu'

# This example application shows how configuration works.
#
# If you have cloned this repository from GitHub, you can run this example:
#
#     ./examples/configuration_app.rb
#
# First, we use the configuration API to switch debugging on, and set the
# logging to go to a file in the /tmp directory.
#
# By passing the arguments: --log /path/to/log_file.log when executing this
# example, we can demonstrate that the client application configuration is
# overridden by command line arguments.
#
# Use 'space' to refresh, 'q' to exit.
#
class VedeuConfigurationApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    # debug!
    log '/tmp/vedeu_configuration_app.log'
    # profile!
  end

  Vedeu.interface 'config' do
    geometry do
      width  40
      height 2
      centred!
    end
  end

  Vedeu.renders do
    view 'config' do
      lines do
        line Configuration.log.inspect + ' ' + Process.pid.to_s
      end
    end
  end

  Vedeu.keymap('config') do
    key(' ') { Vedeu.trigger(:_refresh_, 'config') }

    key('q')        { Vedeu.trigger(:_exit_) }
    key(:escape)    { Vedeu.trigger(:_mode_switch_) }
    key(:shift_tab) { Vedeu.trigger(:_focus_prev_) }
    key(:tab)       { Vedeu.trigger(:_focus_next_) }
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # VedeuConfigurationApp

VedeuConfigurationApp.start(ARGV)
