require 'test_helper'

module Vedeu

  module Renderers

    describe EscapeSequence do

      let(:described) { Vedeu::Renderers::EscapeSequence }
      let(:instance)  { described.new(options) }
      let(:options)   { {} }
      let(:output)    { Vedeu::Models::Page.new }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#clear' do
        subject { instance.clear }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('') }
      end

      describe '#render' do
        subject { instance.render(output) }

        it { subject.must_be_instance_of(String) }

        context 'when there is an empty buffer' do
          let(:expected) { '' }

          it { subject.must_equal(expected) }
        end

        context 'when there is content on the buffer' do
          let(:output) {
            Vedeu::Models::Page.coerce([
              Vedeu::Views::Char.new(value: 't',
                                     colour: {
                                       background: '#ff0000',
                                       foreground: '#ffffff'
                                     }),
              Vedeu::Views::Char.new(value: 'e',
                                     colour: {
                                       background: '#ffff00',
                                       foreground: '#000000'
                                     }),
              Vedeu::Views::Char.new(value: 's',
                                     colour: {
                                       background: '#00ff00',
                                       foreground: '#000000'
                                     }),
              Vedeu::Views::Char.new(value: 't',
                                     colour: {
                                       background: '#00ffff',
                                       foreground: '#000000'
                                     }),
            ])
          }

          it {
            subject.must_equal(
              "\\e[38;2;255;255;255m\\e[48;2;255;0;0mt" \
              "\\e[38;2;0;0;0m\\e[48;2;255;255;0me"     \
              "\\e[38;2;0;0;0m\\e[48;2;0;255;0ms"       \
              "\\e[38;2;0;0;0m\\e[48;2;0;255;255mt"
            )
          }
        end
      end

    end # EscapeSequence

  end # Renderers

end # Vedeu
