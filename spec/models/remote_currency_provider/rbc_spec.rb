require 'rails_helper'

RSpec.describe RemoteCurrencyProviders::Rbc do
  describe '.get_currency' do
    context 'gets currency from rbc.ru' do
      let(:fixture) do
        File.read(Rails.root.join('spec/fixtures/remote_currency_providers/rbc/sample.json'))
      end

      before(:each) do
        expect(Typhoeus).to receive(:get).and_return(
          spy(:response, body: fixture)
        )
      end

      it 'returns stubbed value' do
        expect(described_class.get_currency).to eq('USD_RUB_VALUE')
      end
    end

    context 'internal exception is raised' do
      before(:each) do
        expect(described_class).to receive(:get_data).and_raise(StandardError)
      end

      it 'returns nil' do
        expect(described_class.get_currency).to be_nil
      end

      it 'logs error' do
        expect(Rails.logger).to receive(:error) do |message|
          expect(message).to include('StandardError')
        end
        described_class.get_currency
      end
    end
  end
end
