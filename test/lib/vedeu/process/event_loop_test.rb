require_relative '../../../test_helper'

module Vedeu
  describe EventLoop do
    let(:described_class) { EventLoop }
    let(:defined)         { mock }
    let(:subject)         { described_class.new }

    before do
      Input.stubs(:capture)
      Process.stubs(:evaluate).raises(Collapse)
      Output.stubs(:render)
    end

    it { subject.must_be_instance_of(EventLoop) }

    it { subject.instance_variable_get("@running").must_equal(true) }

    describe '.main_sequence' do
      let(:subject) { described_class.main_sequence }

      # it { subject.must_be_instance_of(FalseClass) }
    end

    describe '#stop' do
      let(:subject) { described_class.new.stop }

      # it { subject.must_be_instance_of(FalseClass) }
    end
  end
end