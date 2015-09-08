#!/usr/bin/env ruby

lib_dir = '/Users/gavinlaking/Source/vedeu/lib/vedeu/distributed/../../../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'vedeu'

# An example application to demonstrate the DRb server.
# If you have cloned this repository from GitHub, you can run this example:
#
#     ./examples/drb_app.rb
#
class VedeuTestApplication

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  # Be aware that running an application with debugging enabled will affect
  # performance.
  Vedeu.configure do
    log         '/tmp/vedeu_test_helper.log'
    # debug!
    drb!
    drb_host    'localhost'
    drb_port    21_420
    drb_width   80
    drb_height  25

    # profile!

    # terminal_mode :raw
    # cooked!
    # fake!
    # raw!

    # run_once!

    # interactive!
    # standalone!

    # System keys can be redefined
    # exit_key        'q'
    # focus_next_key  :tab
    # focus_prev_key  :shift_tab
    # mode_switch_key :escape

    # Not used yet
    # stdin  File.open("/dev/tty", "r")
    # stdout File.open("/dev/tty", "w")
    # stderr File.open("/tmp/vedeu_error.log", "w+")
  end

  Vedeu.border 'test_interface' do
    # Define colour and style of border
    colour foreground: '#ffff00', background: '#0000ff'
    style  'normal'

    # Define visibility of border
    show_bottom!
    show_left!
    show_right!
    show_top!

    # Define characters used to draw border
    bottom_right '+'
    bottom_left  '+'
    horizontal   '-'
    top_right    '+'
    top_left     '+'
    vertical     '|'
  end

  Vedeu.geometry 'test_interface' do
    # centred!
    height 6
    width  26
    x      4
    y      4
  end

  Vedeu.interface 'test_interface' do
    colour foreground: '#ff0000', background: '#000000'
    cursor!
  end

  Vedeu.keymap 'test_interface' do
    key(:up,    'k') { Vedeu.trigger(:_cursor_up_)    }
    key(:right, 'l') { Vedeu.trigger(:_cursor_right_) }
    key(:down,  'j') { Vedeu.trigger(:_cursor_down_)  }
    key(:left,  'h') { Vedeu.trigger(:_cursor_left_)  }

    key('q')        { Vedeu.trigger(:_exit_) }
    key(:escape)    { Vedeu.trigger(:_mode_switch_) }
    key(:shift_tab) { Vedeu.trigger(:_focus_prev_) }
    key(:tab)       { Vedeu.trigger(:_focus_next_) }
  end

  Vedeu.menu 'test_interface' do
    # ...
  end

  Vedeu.renders do
    view 'test_interface' do
      lines do
        line 'a1b1c1d1e1f1g1h1i1j1k1l1m1n1o1p1q1r1s1t1u1v1w1x1y1z1'
        line 'a2b2c2d2e2f2g2h2i2j2k2l2m2n2o2p2q2r2s2t2u2v2w2x2y2z2'
        line 'a3b3c3d3e3f3g3h3i3j3k3l3m3n3o3p3q3r3s3t3u3v3w3x3y3z3'
        line 'a4b4c4d4e4f4g4h4i4j4k4l4m4n4o4p4q4r4s4t4u4v4w4x4y4z4'
        line 'a5b5c5d5e5f5g5h5i5j5k5l5m5n5o5p5q5r5s5t5u5v5w5x5y5z5'
        line 'a6b6c6d6e6f6g6h6i6j6k6l6m6n6o6p6q6r6s6t6u6v6w6x6y6z6'
        line 'a7b7c7d7e7f7g7h7i7j7k7l7m7n7o7p7q7r7s7t7u7v7w7x7y7z7'
        line 'a8b8c8d8e8f8g8h8i8j8k8l8m8n8o8p8q8r8s8t8u8v8w8x8y8z8'
      end
    end
  end

  def self.start(argv = ARGV,
                 stdin = STDIN,
                 stdout = STDOUT,
                 stderr = STDERR,
                 kernel = Kernel)
    Vedeu::Launcher.execute!(argv, stdin, stdout, stderr, kernel)
  end

end # VedeuTestApplication

VedeuTestApplication.start(ARGV)
