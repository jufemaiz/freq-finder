# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Transmitters' do
  include_context 'api v1 request'

  describe 'GET /v1/transmitters.json' do
    describe 'with no location' do
      context 'with no scope' do
        it 'returns a 200' do
          get "#{url}/transmitters.json", headers: basic_headers
          expect(response).to have_http_status :ok
        end
      end

      context 'with station scoped' do
        it 'returns a 200' do
          create_list(:transmitter, 10)
          transmitter = Transmitter.first
          get "#{url}/stations/#{transmitter.station_id}/transmitters.json",
              headers: basic_headers
          expect(response).to have_http_status :ok
        end
      end
    end

    context 'with with location' do
      it 'returns a 200' do
        get "#{url}/transmitters.json",
            params: { 'filter[location]' => '0.0,0.0' },
            headers: basic_headers
        expect(response).to have_http_status :ok
      end
    end
  end

  describe 'GET /v1/transmitters/:id.json' do
    describe 'with no location' do
      context 'with transmitter exists' do
        let(:transmitter) { create(:transmitter) }

        it 'returns a 200' do
          get "#{url}/transmitters/#{transmitter.id}.json", headers: basic_headers
          expect(response).to have_http_status :ok
        end
      end

      context 'with transmitter does not exist' do
        it 'returns a 404' do
          get "#{url}/transmitters/-1.json", headers: basic_headers
          expect(response).to have_http_status :not_found
        end
      end
    end

    describe 'with location' do
      context 'with transmitter exists' do
        let(:transmitter) { create(:transmitter) }

        it 'returns a 200' do
          get "#{url}/transmitters/#{transmitter.id}.json",
              headers: basic_headers,
              params: { 'filter[location]' => '0.0,0.0' }
          expect(response).to have_http_status :ok
        end
      end

      context 'with transmitter does not exist' do
        it 'returns a 404' do
          get "#{url}/transmitters/-1.json", headers: basic_headers
          expect(response).to have_http_status :not_found
        end
      end
    end
  end
end
