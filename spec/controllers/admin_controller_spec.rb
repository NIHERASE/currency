require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  describe 'index' do
    context 'sets @override from repository' do
      let(:override) { Override.new(value: '1', active_until: DateTime.now) }

      it 'sets @override if it exists' do
        expect(OverrideRepository).to receive(:get).and_return(override)
        get :index
        expect(assigns(:override)).to eq(override)
      end

      context 'if currently there is no override sets default' do
        it 'with no value' do
          expect(OverrideRepository).to receive(:get).and_return(nil)
          get :index
          expect(assigns(:override).value).to be_nil
        end

        it 'with active_until in near future' do
          expect(OverrideRepository).to receive(:get).and_return(nil)
          get :index
          expect(assigns(:override).active_until).to be > DateTime.now
        end
      end
    end
  end

  describe 'create' do
    let(:valid_params) do
      { override: { value: '1', active_until: '2017-01-13T07:04+03:00' } }
    end

    let(:invalid_params) do
      { override: { value: 'abc', active_until: '2017-01-13T07:04+03:00' } }
    end

    context 'saves override if it`s valid' do
      it 'calls OverrideService.set' do
        expect(OverrideService).to receive(:set) do |override|
          expect(override.value).to eq('1')
        end
        get :create, params: valid_params
      end
    end

    context 'renders index with @override if it is invalid' do
      it 'assigns override with errors' do
        get :create, params: invalid_params
        expect(assigns(:override).errors).not_to be_empty
      end

      it 'renders index' do
        get :create, params: invalid_params
        expect(response).to render_template(:index)
      end
    end
  end
end
