require 'test_helper'

module Vedeu

  module Logging

    describe MonoLogger do

      let(:described) { Vedeu::Logging::MonoLogger }
      let(:instance)  { described.new(logdev) }
      let(:logdev)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it {
          instance.instance_variable_get('@level').must_equal(Logger::DEBUG)
        }
        it {
          instance.instance_variable_get('@default_formatter').
            must_be_instance_of(::Logger::Formatter)
        }
        it { instance.instance_variable_get('@Formatter').must_equal(nil) }

        context 'when a log device is given' do
          # it {
          #   instance.instance_variable_get('@logdev').
          #     must_be_instance_of(Vedeu::Logging::LocklessLogDevice)
          # }
        end

        context 'when a log device is not given' do
          # it {
          #   instance.instance_variable_get('@logdev').
          #     must_be_instance_of(Vedeu::Logging::LocklessLogDevice)
          # }
        end
      end

    end # MonoLogger

  end # Logging

end # Vedeu
