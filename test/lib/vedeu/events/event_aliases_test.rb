require 'test_helper'

module Vedeu

	describe EventAliases do

    let(:described) { Vedeu::EventAliases }

    before do
      Vedeu::EventAliases.reset
    end
    after do
      Vedeu::Bindings.setup!
    end

    describe '.add' do
      let(:alias_name) { :alias_test }
      let(:event_name) { :event_test }

      subject { described.add(alias_name, event_name) }

      it { described.must_respond_to(:bind_alias) }

      context 'when the alias is already registered' do
        before { Vedeu::EventAliases.add(:alias_test, :event_test) }

        it { subject.must_equal([:event_test, :event_test]) }
      end

      context 'when the alias is not already registered' do
        it { subject.must_equal([:event_test]) }
      end
    end

    describe '.empty?' do
      subject { described.empty? }

      context 'when no aliases are registered' do
        before { Vedeu::EventAliases.reset }

        it { subject.must_equal(true) }
      end

      context 'when aliases are registered' do
        before { Vedeu::EventAliases.add(:alias_test, :event_test) }

        it { subject.must_equal(false) }
      end
    end

    describe '.registered?' do
      let(:alias_name) { :alias_test }

      subject { described.registered?(alias_name) }

      context 'when the alias is registered' do
        before { Vedeu::EventAliases.add(:alias_test, :event_test) }

        it { subject.must_equal(true) }
      end

      context 'when the alias is not registered' do
        it { subject.must_equal(false) }
      end
    end

    describe '.remove' do
      let(:alias_name) { :alias_test }

      before { Vedeu::EventAliases.reset }

      subject { described.remove(alias_name) }

      it { described.must_respond_to(:unbind_alias) }

      context 'when no aliases are registered' do
        it { subject.must_equal(false) }
      end

      context 'when the alias is not registered' do
        before { Vedeu::EventAliases.add(:other_alias_test, :event_test) }

        it { subject.must_equal(false) }
      end

      context 'when the alias is registered' do
        before { Vedeu::EventAliases.add(:alias_test, :event_test) }

        it { subject.must_equal({}) }
      end
    end

    describe '.reset' do
      subject { described.reset }

      it { described.must_respond_to(:reset!) }

      it { subject.must_equal({}) }
    end

    describe '.storage' do
      before { Vedeu::EventAliases.reset }

      subject { described.storage }

      it { subject.must_equal({}) }
    end

    describe '.trigger' do
      let(:alias_name) {}
      let(:args)       {}

      subject { described.trigger(alias_name, *args) }
    end

	end # EventAliases

end # Vedeu