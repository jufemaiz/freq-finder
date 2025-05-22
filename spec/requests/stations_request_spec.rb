# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stations' do
  include_context 'request'

  describe 'GET /stations.json' do
    it 'returns a 200' do
      get "#{url}/stations.json"
      expect(response).to have_http_status :ok
    end
  end

  describe 'GET /stations/:id.json' do
    context 'when station exists' do
      let(:station) { create(:station) }

      it 'returns a 200' do
        get "#{url}/stations/#{station.id}.json"
        expect(response).to have_http_status :ok
      end
    end

    context 'when station does not exist' do
      it 'returns a 404' do
        get "#{url}/stations/-1.json"
        expect(response).to have_http_status :not_found
      end
    end
  end
end
