require 'rails_helper'

RSpec.describe MonitorController, type: :controller do
  describe 'index' do
    let(:value) { '1' }

    it 'sets @ruble_rate from CurrencyRepository' do
      expect(CurrencyRepository).to receive(:get).and_return(value)
      get :index
      expect(assigns(:ruble_rate)).to eq(value)
    end

    it 'sets @ruble_rate to __ if nothing is in CurrencyRepository' do
      expect(CurrencyRepository).to receive(:get).and_return(nil)
      get :index
      expect(assigns(:ruble_rate)).to eq('__')
    end
  end
end
