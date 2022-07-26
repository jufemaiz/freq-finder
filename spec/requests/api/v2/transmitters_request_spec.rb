# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GraphQL Transmitters', type: :request do
  include_context 'api v2 request'

  # You can override `context` or `variables` in
  # more specific scopes
  let(:context) { {} }
  let(:variables) { {} }
  # Call `result` to execute the query
  let(:result) do
    res = FreqFinderSchema.execute(
      query_string,
      context:,
      variables:
    )
    # Print any errors
    pp res if res['errors']
    res
  end

  describe 'List transmitters' do
    let(:query) do
      %({
        allTransmitters {
          edges {
            node {
              band
              frequency
              lat
              lng
            }
          }
        }
      })
    end

    it 'returns a 200' do
      post url, params: { query: }
      expect(response.response_code).to eq 200
    end

    context 'no transmitters' do
      it 'has no errors' do
        post url, params: { query: }
        expect(response.parsed_body['errors']).to eq(nil)
      end
    end

    context '1 transmitter' do
      before(:each) { FactoryBot.create(:transmitter) }

      it 'has no errors' do
        post url, params: { query: }
        expect(response.parsed_body['errors']).to eq(nil)
      end
    end

    context 'many transmitters' do
      before(:each) { FactoryBot.create_list(:transmitter, 10) }

      it 'has no errors' do
        post url, params: { query: }
        expect(response.parsed_body['errors']).to eq(nil)
      end
    end
  end

  describe 'List transmitters spelling error' do
    let(:query) do
      %({ alTransmitters { edges { node { frequency }} } })
    end

    it 'returns a 200 even with an error' do
      post url, params: { query: }
      expect(response.response_code).to eq 200
    end

    context 'no transmitters' do
      it 'has no errors' do
        post url, params: { query: }
        expect(response.parsed_body['errors'].length).to be > 0
      end
    end
  end

  describe 'Show transmitter' do
    let(:query) do
      %|query getTransmitter($transmitterId: ID!) {
        transmitter(id: $transmitterId) {
          frequency
        }
      }|
    end

    context 'transmitter exists' do
      let(:transmitter) { FactoryBot.create(:transmitter) }
      let(:variables) { { 'transmitterId' => transmitter.id } }

      it 'has no errors' do
        post url, params: { query:, variables: }
        expect(response.parsed_body['errors']).to eq(nil)
      end
    end

    # @todo determine why a graphql request for a specific record returns blank
    context 'transmitter does not exist' do
      let(:variables) { { 'transmitterId' => '-1' } }

      it 'empty response' do
        post url, params: { query:, variables: }
        expect(response.parsed_body['data']['transmitter']).to be_nil
      end
    end

    context 'with distance' do
      let(:query) do
        %|query getTransmitter($transmitterId: ID!) {
          transmitter(id: $transmitterId, location: "-33.86,151.21") {
            frequency
            distance
          }
        }|
      end

      let(:transmitter) { FactoryBot.create(:transmitter) }
      let(:variables) { { 'transmitterId' => transmitter.id } }

      it 'has no errors' do
        post url, params: { query:, variables: }
        expect(response.parsed_body['errors']).to eq(nil)
      end
    end
  end
end
