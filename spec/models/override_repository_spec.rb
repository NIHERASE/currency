require 'rails_helper'

RSpec.describe OverrideRepository do
  after(:each) { Redis.current.flushdb }

  let(:value)        { '1' }
  let(:active_until) { DateTime.now + 5.minutes }
  let(:ttl)          { 5.minutes.to_i }
  let(:override)     { Override.new(value: value, active_until: active_until) }


  describe '.get returns current override' do
    context 'there is no current override' do
      it 'returns nil' do
        expect(described_class.get).to be_nil
      end
    end

    context 'returns override' do
      before(:each) do
        Redis.current.setex(described_class::KEY, 5.minutes.to_i, value)
      end

      subject { described_class.get }

      it 'with value from redis' do
        expect(subject.value).to eq(value)
      end

      it 'with active_until based on ttl' do
        expect(subject.active_until).to be_within(1.second).of(active_until)
      end
    end
  end

  describe '.save' do
    context 'saves override under ::KEY' do
      before(:each) do
        described_class.save(override)
      end

      it 'saves value' do
        expect(described_class.get.value).to eq(value)
      end

      it 'saves active_until' do
        expect(described_class.get.active_until).to be_within(1.second).of(active_until)
      end

      it 'sets ttl based on active_until' do
        actial_ttl = Redis.current.ttl(described_class::KEY)
        expect(actial_ttl).to be_within(1).of(ttl)
      end
    end

    context 'active_until already passed' do
      let(:passed_active_until) { DateTime.now - 5.minutes }
      let(:override_with_passed_active_until) do
        override.active_until = passed_active_until
        override
      end

      it 'doesn`t save override' do
        described_class.save(override_with_passed_active_until)
        expect(described_class.get).to be_nil
      end

      it 'deletes current override' do
        described_class.save(override)
        described_class.save(override_with_passed_active_until)
        expect(described_class.get).to be_nil
      end
    end
  end
end
