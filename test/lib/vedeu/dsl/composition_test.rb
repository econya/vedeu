require 'test_helper'

module Vedeu

  module DSL

    describe Composition do

      let(:described) { Vedeu::DSL::Composition }
      let(:instance)  { described.new(model) }
      let(:model)     { Vedeu::Composition.new }

      describe '#initialize' do
        subject { instance }

        it { return_type_for(subject, Vedeu::DSL::Composition) }
        it { assigns(subject, '@model', model) }
      end

      describe '#view' do
        it { skip }

        context 'when the block is not given' do
          subject { instance.view }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end
      end

    end # Composition

  end # DSL

end # Vedeu
