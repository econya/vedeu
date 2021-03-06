require 'test_helper'

module Vedeu

  module Terminal

    describe Mode do

      let(:described) { Vedeu::Terminal::Mode }

      describe '.cooked_mode?' do
        subject { described.cooked_mode? }

        it 'returns true if the terminal is in cooked mode' do
          described.cooked_mode!
          subject.must_equal(true)
        end

        it 'returns false if the terminal is not in cooked mode' do
          described.raw_mode!
          subject.must_equal(false)
        end
      end

      describe '.fake_mode?' do
        subject { described.fake_mode? }

        it 'returns true if the terminal is in fake mode' do
          described.fake_mode!
          subject.must_equal(true)
        end

        it 'returns false if the terminal is not in fake mode' do
          described.raw_mode!
          subject.must_equal(false)
        end
      end

      describe '.raw_mode?' do
        subject { described.raw_mode? }

        it 'returns true if the terminal is in raw mode' do
          described.raw_mode!
          subject.must_equal(true)
        end

        it 'returns false if the terminal is not in raw mode' do
          described.cooked_mode!
          subject.must_equal(false)
        end
      end

      describe '.switch_mode!' do
        subject { described.switch_mode! }

        it 'returns a Symbol' do
          subject.must_be_instance_of(Symbol)
        end

        it 'returns :fake if previously :raw' do
          described.raw_mode!
          subject.must_equal(:fake)
        end

        it 'returns :cooked if previously :fake' do
          described.fake_mode!
          subject.must_equal(:cooked)
        end

        it 'returns :raw if previously :cooked' do
          described.cooked_mode!
          subject.must_equal(:raw)
        end
      end

      describe '.mode' do
        subject { described.mode }

        before do
          described.raw_mode!
          Vedeu::Configuration.stubs(:terminal_mode).returns(:raw)
        end

        it { subject.must_be_instance_of(Symbol) }

        it 'returns the configured terminal mode' do
          subject.must_equal(:raw)
        end
      end

    end # Mode

  end # Terminal

end # Vedeu
