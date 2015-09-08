require 'test_helper'

module Vedeu

  describe MainLoop do

    let(:described) { Vedeu::MainLoop }

    describe '.start!' do
      subject { described.start! { } }
    end

    describe '.stop!' do
      subject { described.stop! }

      it {
        subject
        described.instance_variable_get('@loop').must_equal(false)
      }
    end

    describe '.pause!' do
      subject { described.pause! }

      it {
        subject;
        described.instance_variable_get('@paused').must_equal(true)
      }
    end

    describe '.resume!' do
      subject { described.resume! }

      it {
        subject;
        described.instance_variable_get('@paused').must_equal(false)
      }
    end

    describe '.safe_exit_point!' do
      subject { described.safe_exit_point! }

      context 'when the application has started' do
        context 'when the loop is running' do
          # @todo Add more tests.
          # it { skip }
        end

        context 'when the loop is not running' do
          # @todo Add more tests.
          # it { skip }
        end
      end
    end

  end # MainLoop

end # Vedeu
