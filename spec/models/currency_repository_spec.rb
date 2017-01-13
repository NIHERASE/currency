require 'rails_helper'

RSpec.describe CurrencyRepository do
  after(:each) { Redis.current.flushdb }

  let(:value) { '1' }

  describe '.get' do
    it 'gets currency value from redis' do
      Redis.current.set(described_class::KEY, value)
      expect(described_class.get).to eq(value)
    end

    it 'returns nil if there is no value' do
      expect(described_class.get).to be_nil
    end
  end

  describe '.save' do
    it 'saves value to redis under ::KEY' do
      described_class.save(value)
      expect(described_class.get).to eq(value)
    end
  end
end
