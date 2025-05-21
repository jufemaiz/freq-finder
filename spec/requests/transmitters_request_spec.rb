# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Transmitters' do
  include_context 'request'

  describe 'GET /transmitters.json' do
    describe 'with no location' do
      context 'with no scope' do
        it 'returns a 200' do
          get "#{url}/transmitters.json"
          expect(response).to have_http_status :ok
        end
      end

      context 'with station scoped' do
        it 'returns a 200' do
          create_list(:transmitter, 10)
          transmitter = Transmitter.first
          get "#{url}/stations/#{transmitter.station_id}/transmitters.json"
          expect(response).to have_http_status :ok
        end
      end
    end

    context 'with with location' do
      it 'returns a 200' do
        get "#{url}/transmitters.json", params: { location: '0.0,0.0' }
        expect(response).to have_http_status :ok
      end
    end
  end

  describe 'GET /transmitters/:id.json' do
    describe 'with no location' do
      context 'with transmitter exists' do
        let(:transmitter) { create(:transmitter) }

        it 'returns a 200' do
          get "#{url}/transmitters/#{transmitter.id}.json"
          expect(response).to have_http_status :ok
        end
      end

      context 'with transmitter does not exist' do
        it 'returns a 404' do
          get "#{url}/transmitters/-1.json"
          expect(response).to have_http_status :not_found
        end
      end
    end

    describe 'with location' do
      context 'with transmitter exists' do
        let(:transmitter) { create(:transmitter) }

        it 'returns a 200' do
          get "#{url}/transmitters/#{transmitter.id}.json", params: { location: '0.0,0.0' }
          expect(response).to have_http_status :ok
        end
      end

      context 'with transmitter does not exist' do
        it 'returns a 404' do
          get "#{url}/transmitters/-1.json"
          expect(response).to have_http_status :not_found
        end
      end
    end
  end
end
