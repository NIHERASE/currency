require 'rails_helper'

RSpec.describe RemoteCurrencyProviders::Dummy do
  describe '.get_currency' do
    it 'returns dummy value' do
      expect(described_class.get_currency).to eq(described_class::VALUE)
    end
  end
end
