# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GraphQL Stations' do
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
    Rails.logger.debug res if res['errors']
    res
  end

  describe 'List stations' do
    let(:query) do
      %({ allStations { edges { node { title } } } })
    end

    it 'returns a 200' do
      post url, params: { query: }
      expect(response.response_code).to eq 200
    end

    context 'with no stations' do
      it 'has no errors' do
        post url, params: { query: }
        expect(response.parsed_body['errors']).to be_nil
      end
    end

    context 'with 1 station' do
      before { create(:station) }

      it 'has no errors' do
        post url, params: { query: }
        expect(response.parsed_body['errors']).to be_nil
      end
    end

    context 'with many stations' do
      before { create_list(:station, 10) }

      it 'has no errors' do
        post url, params: { query: }
        expect(response.parsed_body['errors']).to be_nil
      end
    end
  end

  describe 'List stations spelling error' do
    let(:query) do
      %({ alStations { edges { node { title }} } })
    end

    it 'returns a 200 even with an error' do
      post url, params: { query: }
      expect(response.response_code).to eq 200
    end

    context 'with no stations' do
      it 'has no errors' do
        post url, params: { query: }
        expect(response.parsed_body['errors'].length).to be > 0
      end
    end
  end

  describe 'Show station' do
    let(:query) do
      %|query getStation($stationId: ID!) {
        station(id: $stationId) {
          title
        }
      }|
    end

    context 'with station exists' do
      let(:station) { create(:station) }
      let(:variables) { { 'stationId' => station.id } }

      it 'has no errors' do
        post url, params: { query:, variables: }
        expect(response.parsed_body['errors']).to be_nil
      end
    end

    # @todo determine why a graphql request for a specific record returns blank
    context 'with station does not exist' do
      let(:variables) { { 'stationId' => '-1' } }

      it 'empty response' do
        post url, params: { query:, variables: }
        expect(response.parsed_body).to be_blank
      end
    end
  end

  describe 'Show station with transmitters' do
    let(:query) do
      %|query getStation($stationId: ID!) {
        station(id: $stationId) {
          title
          transmitters {
            edges {
              node {
                band
              }
            }
          }
        }
      }|
    end

    context 'with station exists' do
      let(:station) { create(:station) }
      let(:variables) { { 'stationId' => station.id } }

      it 'has no errors' do
        post url, params: { query:, variables: }
        expect(response.parsed_body['errors']).to be_nil
      end
    end

    # @todo determine why a graphql request for a specific record returns blank
    context 'with station does not exist' do
      let(:variables) { { 'stationId' => '-1' } }

      it 'empty response' do
        post url, params: { query:, variables: }
        expect(response.parsed_body).to be_blank
      end
    end
  end

  describe 'Show station with transmitters with location' do
    let(:query) do
      %|query getStation($stationId: ID!) {
        station(id: $stationId) {
          title
          transmitters(location: "-33.865143,151.209900") {
            edges {
              node{
                band
                frequency
                distance
              }
            }
          }
        }
      }|
    end

    context 'with station exists' do
      let(:station) { create(:station) }
      let(:variables) { { 'stationId' => station.id } }

      it 'has no errors' do
        post url, params: { query:, variables: }
        expect(response.parsed_body['errors']).to be_nil
      end
    end

    # @todo determine why a graphql request for a specific record returns blank
    context 'with station does not exist' do
      let(:variables) { { 'stationId' => '-1' } }

      it 'empty response' do
        post url, params: { query:, variables: }
        expect(response.parsed_body).to be_blank
      end
    end
  end
end
