require 'rails_helper'

RSpec.describe OverrideService do
  describe '.set' do
    context 'override is active' do
      let(:override) { Override.new(value: '1', active_until: DateTime.now + 5.minutes) }

      it 'saves override' do
        expect(OverrideRepository).to receive(:save).with(override).and_return('OK')
        expect(CurrencyRepository).to receive(:save).with(override.value)
        expect(CurrencyChannel).to receive(:broadcast).with(override.value)
        described_class.set(override)
      end
    end
  end
end
