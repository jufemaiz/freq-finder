require 'rails_helper'

RSpec.describe 'Transmitters', type: :request do
  include_context 'api v1 request'

  describe 'GET /v1/transmitters' do
    describe 'with no location' do
      context 'no scope' do
        it 'returns a 200' do
          get "#{url}/transmitters.json", headers: basic_headers
          expect(response.code).to eq '200'
        end
      end

      context 'station scoped' do
        it 'returns a 200' do
          FactoryBot.create_list(:transmitter, 10)
          transmitter = Transmitter.first
          get "#{url}/stations/#{transmitter.station_id}/transmitters.json", headers: basic_headers
          expect(response.code).to eq '200'
        end
      end
    end

    context 'with location' do
      it 'returns a 200' do
        get "#{url}/transmitters.json", params: { 'filter[near]' => '0.0,0.0' }, headers: basic_headers
        expect(response.code).to eq '200'
      end
    end
  end

  describe 'GET /v1/transmitters' do
    describe 'with no location' do
      context 'transmitter exists' do
        let(:transmitter) { FactoryBot.create(:transmitter) }

        it 'returns a 200' do
          get "#{url}/transmitters/#{transmitter.id}.json", headers: basic_headers
          expect(response.code).to eq '200'
        end
      end

      context 'transmitter does not exist' do

        it 'returns a 404' do
          get "#{url}/transmitters/-1.json", headers: basic_headers
          expect(response.code).to eq '404'
        end
      end
    end

    describe 'with location' do
      context 'transmitter exists' do
        let(:transmitter) { FactoryBot.create(:transmitter) }

        it 'returns a 200' do
          get "#{url}/transmitters/#{transmitter.id}.json", params: { 'filter[near]' => '0.0,0.0' }, headers: basic_headers
          expect(response.code).to eq '200'
        end
      end

      context 'transmitter does not exist' do

        it 'returns a 404' do
          get "#{url}/transmitters/-1.json", headers: basic_headers
          expect(response.code).to eq '404'
        end
      end
    end
  end
end
