# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stations', type: :request do
  include_context 'api v1 request'

  describe 'GET /v1/stations' do
    it 'returns a 200' do
      get "#{url}/stations.json", headers: basic_headers
      expect(response.code).to eq '200'
    end
  end

  describe 'GET /v1/stations' do
    context 'station exists' do
      let(:station) { FactoryBot.create(:station) }

      it 'returns a 200' do
        get "#{url}/stations/#{station.id}.json", headers: basic_headers
        expect(response.code).to eq '200'
      end
    end

    context 'station does not exist' do
      it 'returns a 404' do
        get "#{url}/stations/-1.json", headers: basic_headers
        expect(response.code).to eq '404'
      end
    end
  end
end
