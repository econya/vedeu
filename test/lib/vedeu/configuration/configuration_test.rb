require 'test_helper'

module Vedeu

  describe Configuration do

    let(:described) { Vedeu::Configuration }

    before { Configuration.reset! }
    after  { test_configuration }

    describe '.base_path' do
      it { described.must_respond_to(:base_path) }

      it 'returns the value of the base_path option' do
        Configuration.base_path.must_equal(Dir.pwd)
      end
    end

    describe '.compression?' do
      it { described.must_respond_to(:compression) }

      it 'returns the value of the compression option' do
        Configuration.compression?.must_equal(true)
      end
    end

    describe '.debug?' do
      it { described.must_respond_to(:debug) }

      it 'returns the value of the debug option' do
        Configuration.debug?.must_equal(false)
      end
    end

    describe '.drb?' do
      it { described.must_respond_to(:drb) }

      it 'returns the value of the drb option' do
        Configuration.drb?.must_equal(false)
      end
    end

    describe '.interactive?' do
      it { described.must_respond_to(:interactive) }

      it 'returns the value of the interactive option' do
        Configuration.interactive?.must_equal(true)
      end
    end

    describe '.log' do
      context 'when the log is not configured' do
        it { described.log.must_equal(nil) }
      end

      context 'when the log is configured' do
        before do
          Vedeu.configure do
            log '/tmp/vedeu.log'
          end
        end

        it { described.log.must_equal('/tmp/vedeu.log') }
      end
    end

    describe '.log?' do
      context 'when the log is not configured' do
        it { described.log?.must_equal(false) }
      end

      context 'when the log is configured' do
        before do
          Vedeu.configure do
            log '/tmp/vedeu.log'
          end
        end

        it { described.log?.must_equal(true) }
      end
    end

    describe '.log_only' do
      context 'when log_only is not configured' do
        it { described.log_only.must_equal([]) }
      end

      context 'when log_only is configured' do
        before do
          Vedeu.configure do
            log_only :timer, :event
          end
        end

        it { described.log_only.must_equal([:timer, :event]) }
      end
    end

    describe '.once?' do
      it { described.must_respond_to(:once) }

      it 'returns the value of the once option' do
        Configuration.once?.must_equal(false)
      end
    end

    describe '.profile?' do
      it { described.must_respond_to(:profile) }

      it 'returns the value of the profile option' do
        Configuration.profile?.must_equal(false)
      end
    end

    describe '.stdin' do
      it 'returns the value of the redefined STDIN' do
        Configuration.stdin.must_equal(nil)
      end
    end

    describe '.stdout' do
      it 'returns the value of the redefined STDOUT' do
        Configuration.stdout.must_equal(nil)
      end
    end

    describe '.stderr' do
      it 'returns the value of the redefined STDERR' do
        Configuration.stderr.must_equal(nil)
      end
    end

    describe '.terminal_mode' do
      it 'returns the value of the mode option' do
        Configuration.terminal_mode.must_equal(:raw)
      end
    end

    describe '.configure' do
      it 'returns the options configured' do
        Configuration.configure do
          # ...
        end.must_equal(Vedeu::Configuration)
      end
    end

  end # Configuration

end # Vedeu
