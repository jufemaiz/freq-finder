# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GraphQL Stations', type: :request do
  include_context 'api v2 request'

  # You can override `context` or `variables` in
  # more specific scopes
  let(:context) { {} }
  let(:variables) { {} }
  # Call `result` to execute the query
  let(:result) do
    res = FreqFinderSchema.execute(
      query_string,
      context: context,
      variables: variables
    )
    # Print any errors
    pp res if res['errors']
    res
  end

  describe 'List stations' do
    let(:query) do
      %({ allStations { edges { node { title } } } })
    end

    it 'returns a 200' do
      post url, params: { query: query }
      expect(response.response_code).to eq 200
    end

    context 'no stations' do
      it 'has no errors' do
        post url, params: { query: query }
        expect(response.parsed_body['errors']).to eq(nil)
      end
    end

    context '1 station' do
      before(:each) { FactoryBot.create(:station) }

      it 'has no errors' do
        post url, params: { query: query }
        expect(response.parsed_body['errors']).to eq(nil)
      end
    end

    context 'many stations' do
      before(:each) { FactoryBot.create_list(:station, 10) }

      it 'has no errors' do
        post url, params: { query: query }
        expect(response.parsed_body['errors']).to eq(nil)
      end
    end
  end

  describe 'List stations spelling error' do
    let(:query) do
      %({ alStations { edges { node { title }} } })
    end

    it 'returns a 200 even with an error' do
      post url, params: { query: query }
      expect(response.response_code).to eq 200
    end

    context 'no stations' do
      it 'has no errors' do
        post url, params: { query: query }
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

    context 'station exists' do
      let(:station) { FactoryBot.create(:station) }
      let(:variables) { { 'stationId' => station.id } }

      it 'has no errors' do
        post url, params: { query: query, variables: variables }
        expect(response.parsed_body['errors']).to eq(nil)
      end
    end

    # @todo determine why a graphql request for a specific record returns blank
    context 'station does not exist' do
      let(:variables) { { 'stationId' => '-1' } }

      it 'empty response' do
        post url, params: { query: query, variables: variables }
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

    context 'station exists' do
      let(:station) { FactoryBot.create(:station) }
      let(:variables) { { 'stationId' => station.id } }

      it 'has no errors' do
        post url, params: { query: query, variables: variables }
        expect(response.parsed_body['errors']).to eq(nil)
      end
    end

    # @todo determine why a graphql request for a specific record returns blank
    context 'station does not exist' do
      let(:variables) { { 'stationId' => '-1' } }

      it 'empty response' do
        post url, params: { query: query, variables: variables }
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

    context 'station exists' do
      let(:station) { FactoryBot.create(:station) }
      let(:variables) { { 'stationId' => station.id } }

      it 'has no errors' do
        post url, params: { query: query, variables: variables }
        expect(response.parsed_body['errors']).to eq(nil)
      end
    end

    # @todo determine why a graphql request for a specific record returns blank
    context 'station does not exist' do
      let(:variables) { { 'stationId' => '-1' } }

      it 'empty response' do
        post url, params: { query: query, variables: variables }
        expect(response.parsed_body).to be_blank
      end
    end
  end
end
