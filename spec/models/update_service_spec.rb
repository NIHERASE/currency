require 'rails_helper'

RSpec.describe UpdateService, type: :model do
  describe '.run starts updated with interval' do
    it 'calls scheduler.interval with update in block and joins' do
      expect_any_instance_of(Rufus::Scheduler).to receive(:interval) do |&block|
        block.call
      end
      expect(UpdateService).to receive(:update)
      expect_any_instance_of(Rufus::Scheduler).to receive(:join)
      UpdateService.run
    end
  end

  describe '.update' do
    context 'when there is no current override' do
      let(:value) { '1' }

      it 'gets, saves, and broadcasts currency' do
        expect(RemoteCurrencyProviders).to receive(:get_currency).and_return(value)
        expect(CurrencyRepository).to receive(:save).with(value)
        expect(CurrencyChannel).to receive(:broadcast).with(value)
        UpdateService.update
      end
    end
  end
end
