#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

-> { its -> { a } }
trap('INT') { exit! }

require 'vedeu'

class VedeuCursorApp
  include Vedeu

  event(:_initialize_) { Vedeu.trigger(:_refresh_) }

  interface 'iron' do
    cursor  true
    colour  foreground: '#ff0000', background: '#000000'

    geometry do
      centred true
      height  4
      width   15
    end

    # provide 'vim' direction keys
    keys do
      key('k') { Vedeu.trigger(:_cursor_up_)    }
      key('l') { Vedeu.trigger(:_cursor_right_) }
      key('j') { Vedeu.trigger(:_cursor_down_)  }
      key('h') { Vedeu.trigger(:_cursor_left_)  }
    end
  end

  interface 'gold' do
    cursor false
    colour foreground: '#00ff00', background: '#001100'

    geometry do
      height 4
      width  15
      x      use('iron').left
      y      use('iron').south
    end
  end

  keys do
    key(:up)    { Vedeu.trigger(:_cursor_up_)    }
    key(:right) { Vedeu.trigger(:_cursor_right_) }
    key(:down)  { Vedeu.trigger(:_cursor_down_)  }
    key(:left)  { Vedeu.trigger(:_cursor_left_)  }
  end

  renders do
    view 'iron' do
      lines do
        stream do
          text 'A 23456789 '
        end
        stream do
          background '#550000'
          foreground '#ffff00'
          text 'hydrogen'
        end
        stream do
          text ' helium'
        end
      end
      lines do
        line 'B 23456789 lithium beryllium boron nitrogen'
      end
      lines do
        stream do
          text 'C 23456789'
        end
        stream do
          text ' carbon oxygen '
        end
        stream do
          background '#aadd00'
          foreground '#000000'
          text 'fluorine'
        end
      end
      lines do
        line 'D 23456789'
      end
      lines do
        line 'E 23456789 neon sodium'
      end
      lines do
        stream do
          text 'F 23456789 magnesium '
        end
        stream do
          foreground '#00aaff'
          text 'aluminium'
        end
      end
      lines do
        line 'G 23456789 silicon'
      end
      lines do
        stream do
          background '#550000'
          foreground '#ff00ff'
          text 'H 234'
        end
      end
    end

    view 'gold' do
      cursor false
      lines do
        line 'Cursor: '
      end
    end
  end

  focus('iron') # not working right?!

  Vedeu.configure do
    debug!
    log '/tmp/vedeu_cursor_app.log'
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.new(argv).execute!
  end
end

VedeuCursorApp.start(ARGV)
