require 'test_helper'

module Vedeu

  describe Debug do

    let(:described) { Vedeu::Debug }

    before do
      File.stubs(:open).with('/tmp/profile.html', 'w').returns(:some_code)
    end

    describe '.debug' do
    end

    describe '.profile' do
      let(:filename)  { 'profile.html' }
      let(:some_code) { :some_code }

      context 'when the block is not given' do
        subject { described.profile(filename) }

        it { subject.must_equal(nil) }
      end

      context 'when the block is given' do
        subject { described.profile(filename) { some_code } }

        it {
          ::File.expects(:open).with('/tmp/profile.html', 'w')
          subject
        }
      end
    end

  end # Debug

end # Vedeu
