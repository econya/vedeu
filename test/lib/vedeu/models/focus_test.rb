require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_focus_by_name_).must_equal(true) }
    it { Vedeu.bound?(:_focus_next_).must_equal(true) }
    it { Vedeu.bound?(:_focus_prev_).must_equal(true) }
  end

  module Models

    describe Focus do

      let(:described) { Vedeu::Models::Focus }

      before do
        Vedeu.stubs(:log)

        Vedeu::Models::Focus.reset
        Vedeu.interfaces.reset

        Vedeu.stubs(:trigger)
      end
      after do
        Vedeu::Models::Focus.reset
        Vedeu.interfaces.reset
      end

      describe '#add' do
        context 'adds an interface to storage' do
          it { Vedeu::Models::Focus.add('thallium').must_equal(['thallium']) }
        end

        context 'does not add it again if already exists' do
          before { Vedeu.interface('thallium') {} }

          it {
            Vedeu::Models::Focus.add('thallium')
            Vedeu::Models::Focus.registered.must_equal(['thallium'])
          }
        end

        it 'does not add it again if already exists' do
          Vedeu::Models::Focus.add('thallium')
          Vedeu::Models::Focus.add('lead')
          Vedeu::Models::Focus.add('bismuth')
          Vedeu::Models::Focus.add('bismuth', true)
          Vedeu::Models::Focus.registered.must_equal(
            ['bismuth', 'thallium', 'lead']
          )
        end

        context 'adds the interface to storage focussed' do
          before { Vedeu.interface('thallium') {} }

          it {
            Vedeu::Models::Focus.add('thallium')
            Vedeu::Models::Focus.add('lead', true)
            Vedeu::Models::Focus.registered.must_equal(['lead', 'thallium'])
          }
        end

        context 'adds the interface to storage unfocussed' do
          before { Vedeu.interface('thallium') {} }

          it {
            Vedeu::Models::Focus.add('thallium')
            Vedeu::Models::Focus.add('lead')
            Vedeu::Models::Focus.registered.must_equal(['thallium', 'lead'])
          }
        end
      end

      describe '#by_name' do
        it 'the named interface is focussed when the method is called' do
          Vedeu::Models::Focus.add('thallium')
          Vedeu::Models::Focus.add('lead')
          Vedeu::Models::Focus.add('bismuth')
          Vedeu::Models::Focus.by_name('lead').must_equal('lead')
        end

        it 'raises an exception if the interface does not exist' do
          proc { Vedeu::Models::Focus.by_name('not_found') }.
            must_raise(Vedeu::Error::ModelNotFound)
        end

        context 'API methods' do
          it 'the named interface is focussed when the method is called' do
            Vedeu::Models::Focus.add('thallium')
            Vedeu::Models::Focus.add('lead')
            Vedeu::Models::Focus.add('bismuth')
            Vedeu.focus_by_name('lead').must_equal('lead')
          end

          it 'raises an exception if the interface does not exist' do
            proc { Vedeu.focus_by_name('not_found') }.
              must_raise(Vedeu::Error::ModelNotFound)
          end
        end
      end

      describe '#current' do
        before { Vedeu::Models::Focus.reset }

        subject { described.current }

        it 'returns the name of the interface currently in focus' do
          Vedeu::Models::Focus.add('thallium')
          Vedeu::Models::Focus.add('lead')
          Vedeu::Models::Focus.add('bismuth')
          subject.must_equal('thallium')
        end

        context 'when no interfaces are defined' do
          it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
        end

        context 'API methods' do
          it 'returns the name of the interface currently in focus' do
            Vedeu::Models::Focus.add('thallium')
            Vedeu::Models::Focus.add('lead')
            Vedeu::Models::Focus.add('bismuth')
            Vedeu.focus.must_equal('thallium')
          end
        end
      end

      describe '#current?' do
        before { Vedeu::Models::Focus.stubs(:current).returns('lead') }

        context 'when the interface is currently in focus' do
          it { Vedeu::Models::Focus.current?('lead').must_equal(true) }
        end

        context 'when the interface is not currently in focus' do
          it { Vedeu::Models::Focus.current?('bismuth').must_equal(false) }
        end

        context 'API methods' do
          context 'when the interface is currently in focus' do
            it { Vedeu.focussed?('lead').must_equal(true) }
          end

          context 'when the interface is not currently in focus' do
            it { Vedeu.focussed?('bismuth').must_equal(false) }
          end
        end
      end

      describe '#next_item' do
        it 'the next interface is focussed when the method is called' do
          Vedeu::Models::Focus.add('thallium')
          Vedeu::Models::Focus.add('lead')
          Vedeu::Models::Focus.add('bismuth')
          Vedeu::Models::Focus.next_item.must_equal('lead')
        end

        context 'returns false if storage is empty' do
          before { Vedeu::Models::Focus.reset }

          it { Vedeu::Models::Focus.next_item.must_equal(false) }
        end
      end

      describe '#next_visible_item' do
        before do
          Vedeu.stubs(:trigger)
          Vedeu.interface('gold') { visible true }
          Vedeu.interface('silver') { visible true }
          Vedeu.interface('platinum') { visible false }
        end

        it 'the next visible interface is focussed when the method is called' do
          Vedeu::Models::Focus.next_visible_item.must_equal('silver')
        end

        context 'when there are no visible interfaces' do
          before {
            Vedeu.interface('gold') { visible false }
            Vedeu.interface('silver') { visible false }
            Vedeu.interface('platinum') { visible false }
          }

          it 'puts the first interface defined in focus' do
            Vedeu::Models::Focus.next_visible_item.must_equal('gold')
          end
        end

        context 'when there are no interfaces' do
          before { Vedeu::Models::Focus.reset }

          it { Vedeu::Models::Focus.next_visible_item.must_equal(false) }
        end
      end

      describe '#prev_item' do
        it 'the previous interface is focussed when the method is called' do
          Vedeu::Models::Focus.add('thallium')
          Vedeu::Models::Focus.add('lead')
          Vedeu::Models::Focus.add('bismuth')
          Vedeu::Models::Focus.prev_item.must_equal('bismuth')
        end

        context 'returns false if storage is empty' do
          before { Vedeu::Models::Focus.reset }

          it { Vedeu::Models::Focus.prev_item.must_equal(false) }
        end
      end

      describe '#prev_visible_item' do
        before do
          Vedeu.stubs(:trigger)
          Vedeu.interface('gold') { visible true }
          Vedeu.interface('silver') { visible true }
          Vedeu.interface('platinum') { visible false }
        end

        it 'the previous visible interface is focussed when the method is ' \
           'called' do
          Vedeu::Models::Focus.prev_visible_item.must_equal('silver')
        end

        context 'when there are no visible interfaces' do
          before do
            Vedeu.interface('gold') { visible false }
            Vedeu.interface('silver') { visible false }
            Vedeu.interface('platinum') { visible false }
          end

          it 'puts the first interface defined in focus' do
            Vedeu::Models::Focus.prev_visible_item.must_equal('gold')
          end
        end

        context 'when there are no interfaces' do
          before { Vedeu::Models::Focus.reset }

          it { Vedeu::Models::Focus.prev_visible_item.must_equal(false) }
        end
      end

      describe '#refresh' do
        before do
          Vedeu::Models::Focus.add('thallium')
          Vedeu.stubs(:trigger).returns([])
        end

        it 'triggers the event to refresh the interface current in focus' do
          Vedeu::Models::Focus.refresh.must_equal([])
        end
      end

    end # Focus

  end # Models

end # Vedeu
