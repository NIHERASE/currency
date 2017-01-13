require 'rails_helper'

RSpec.describe RemoteCurrencyProviders, type: :model do
  describe '.get_currency iterates PROVIDERS until response is returned' do
    let(:value) { '1' }

    it 'first provider returns' do
      stub_const(
        'RemoteCurrencyProviders::PROVIDERS',
        [spy(:p1, get_currency: value), spy(:p1, get_currency: '_')]
      )
      expect(described_class.get_currency).to eq(value)
    end

    it 'some provider returns' do
      stub_const(
        'RemoteCurrencyProviders::PROVIDERS',
        [spy(:p1, get_currency: nil), spy(:p1, get_currency: value)]
      )
      expect(described_class.get_currency).to eq(value)
    end
  end
end
