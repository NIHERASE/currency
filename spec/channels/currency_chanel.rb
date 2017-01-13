require 'rails_helper'

RSpec.describe CurrencyChannel do
  describe '.broadcast' do
    let(:value) { '1' }

    it 'calls broadcast_to with `broadcast` and value' do
      expect(CurrencyChannel).to receive(:broadcast_to).with('broadcast', value)
      CurrencyChannel.broadcast(value)
    end
  end
end
