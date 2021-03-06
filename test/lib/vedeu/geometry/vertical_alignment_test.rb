require 'test_helper'

module Vedeu

  module Geometry

    describe VerticalAlignment do

      let(:described) { Vedeu::Geometry::VerticalAlignment }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}

      describe '.align' do
        subject { described.align(_value) }

        context 'when the value is :none' do
          let(:_value) { :none }

          it { subject.must_equal(:none) }
        end

        context 'when the value is nil' do
          it { subject.must_equal(:none) }
        end

        context 'when the value is not a Symbol' do
          let(:_value) { 'invalid' }

          it { subject.must_equal(:none) }
        end

        context 'when the value is :bottom' do
          let(:_value) { :bottom }

          it { subject.must_equal(:bottom) }
        end

        context 'when the value is :middle' do
          let(:_value) { :middle }

          it { subject.must_equal(:middle) }
        end

        context 'when the value is :top' do
          let(:_value) { :top }

          it { subject.must_equal(:top) }
        end

        context 'when the value is :align_invalid' do
          let(:_value) { :align_invalid }

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

    end # VerticalAlignment

  end # Geometry

end # Vedeu
