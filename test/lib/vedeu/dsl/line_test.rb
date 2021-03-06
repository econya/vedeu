require 'test_helper'

module Vedeu

  module DSL

    describe Line do

      let(:described)  { Vedeu::DSL::Line }
      let(:instance)   { described.new(model) }
      let(:model)      { Vedeu::Views::Line.new(attributes) }
      let(:client)     {}
      let(:colour)     { Vedeu::Colours::Colour.new }
      let(:parent)     { Vedeu::Views::View.new }
      let(:style)      { Vedeu::Presentation::Style.new }
      let(:_value)     { [] }
      let(:attributes) {
        {
          client: client,
          value:  _value,
          parent: parent,
          colour: colour,
          style:  style,
        }
      }

      describe '#line' do
        let(:_value) { '' }

        subject {
          instance.line do
            # ...
          end
        }

        it { subject.must_be_instance_of(Vedeu::Views::Lines) }
        it { subject[0].must_be_instance_of(Vedeu::Views::Line) }
        it { instance.must_respond_to(:line=) }

        context 'when the block is given' do
        end

        context 'when the block is not given' do
          context 'when the value is given' do
            subject { instance.line(_value) }
          end

          context 'when the value is not given' do
            let(:_value) {}

            subject { instance.line(_value) }

            it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
          end
        end
      end

      describe '#streams' do
        context 'when the block is given' do
          subject {
            instance.streams do
              # ...
            end
          }

          it { subject.must_be_instance_of(Vedeu::Views::Streams) }
          it { subject[0].must_be_instance_of(Vedeu::Views::Stream) }
        end

        context 'when the block is not given' do
          it {
            proc { instance.streams }.must_raise(Vedeu::Error::RequiresBlock)
          }
        end

        it { instance.must_respond_to(:stream) }
        it { instance.must_respond_to(:stream=) }
        it { instance.must_respond_to(:streams=) }
      end

    end # Line

  end # DSL

end # Vedeu
