require 'rails_helper'

RSpec.describe 'Stations', type: :request do
  include_context 'request'

  describe 'GET /stations' do
    it 'returns a 200' do
      get "#{url}/stations.json"
      expect(response.code).to eq '200'
    end
  end

  describe 'GET /stations' do
    context 'station exists' do
      let(:station) { FactoryBot.create(:station) }

      it 'returns a 200' do
        get "#{url}/stations/#{station.id}.json"
        expect(response.code).to eq '200'
      end
    end

    context 'station does not exist' do

      it 'returns a 404' do
        get "#{url}/stations/-1.json"
        expect(response.code).to eq '404'
      end
    end
  end
end
