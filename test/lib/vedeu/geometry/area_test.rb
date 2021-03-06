require 'test_helper'

module Vedeu

  module Geometry

    describe Area do

      let(:described) { Vedeu::Geometry::Area }
      let(:instance)  { described.new(y: y, yn: yn, x: x, xn: xn) }
      let(:y)         { 4 }
      let(:yn)        { 9 }
      let(:x)         { 6 }
      let(:xn)        { 21 }
      let(:offset)    { 1 }

      describe 'accessors' do
        it {
          instance.must_respond_to(:y)
          instance.must_respond_to(:yn)
          instance.must_respond_to(:x)
          instance.must_respond_to(:xn)
          instance.must_respond_to(:top)
          instance.must_respond_to(:bottom)
          instance.must_respond_to(:left)
          instance.must_respond_to(:right)
        }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@y').must_equal(y) }
        it { instance.instance_variable_get('@yn').must_equal(yn) }
        it { instance.instance_variable_get('@x').must_equal(x) }
        it { instance.instance_variable_get('@xn').must_equal(xn) }
      end

      describe '.from_attributes' do
        let(:attributes) {
          {
            y:                    y,
            yn:                   yn,
            y_yn:                 y_yn,
            y_default:            y_default,
            x:                    x,
            xn:                   xn,
            x_xn:                 x_xn,
            x_default:            x_default,
            maximised:            maximised,
            horizontal_alignment: horizontal_alignment,
            vertical_alignment:   vertical_alignment,
          }
        }
        let(:y)                    {}
        let(:yn)                   {}
        let(:y_yn)                 {}
        let(:y_default)            {}
        let(:x)                    {}
        let(:xn)                   {}
        let(:x_xn)                 {}
        let(:x_default)            {}
        let(:maximised)            {}
        let(:horizontal_alignment) {}
        let(:vertical_alignment)   {}

        subject { described.from_attributes(attributes) }

        it { subject.must_be_instance_of(described) }
      end

      describe '#eql?' do
        let(:other) { described.new(y: 4, yn: 9, x: 6, xn: 21) }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new(y: 1, yn: 25, x: 1, xn: 40) }

          it { subject.must_equal(false) }
        end
      end

      describe '#centre' do
        subject { instance.centre }

        it { subject.must_be_instance_of(Array) }
        it { subject.must_equal([7, 14]) }
      end

      describe '#centre_y' do
        subject { instance.centre_y }

        it { subject.must_be_instance_of(Fixnum) }
        it { subject.must_equal(7) }
      end

      describe '#centre_x' do
        subject { instance.centre_x }

        it { subject.must_be_instance_of(Fixnum) }
        it { subject.must_equal(14) }
      end

      describe '#north' do
        subject { instance.north(offset) }

        it { subject.must_be_instance_of(Fixnum) }

        context 'with the default offset' do
          it { subject.must_equal(3) }
        end

        context 'with a negative offset' do
          let(:offset) { -2 }

          it { subject.must_equal(6) }
        end

        context 'with a positive offset' do
          let(:offset) { 2 }

          it { subject.must_equal(2) }
        end
      end

      describe '#east' do
        subject { instance.east(offset) }

        it { subject.must_be_instance_of(Fixnum) }

        context 'with the default offset' do
          it { subject.must_equal(22) }
        end

        context 'with a negative offset' do
          let(:offset) { -2 }

          it { subject.must_equal(19) }
        end

        context 'with a positive offset' do
          let(:offset) { 2 }

          it { subject.must_equal(23) }
        end
      end

      describe '#south' do
        subject { instance.south(offset) }

        it { subject.must_be_instance_of(Fixnum) }

        context 'with the default offset' do
          it { subject.must_equal(10) }
        end

        context 'with a negative offset' do
          let(:offset) { -2 }

          it { subject.must_equal(7) }
        end

        context 'with a positive offset' do
          let(:offset) { 2 }

          it { subject.must_equal(11) }
        end
      end

      describe '#west' do
        subject { instance.west(offset) }

        it { subject.must_be_instance_of(Fixnum) }

        context 'with the default offset' do
          it { subject.must_equal(5) }
        end

        context 'with a negative offset' do
          let(:offset) { -2 }

          it { subject.must_equal(8) }
        end

        context 'with a positive offset' do
          let(:offset) { 2 }

          it { subject.must_equal(4) }
        end
      end

    end # Area

  end # Geometry

end # Vedeu
