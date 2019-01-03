require 'rails_helper'

RSpec.describe 'GraphQL Stations', type: :request do
  include_context 'api v2 request'

  # You can override `context` or `variables` in
  # more specific scopes
  let(:context) { {} }
  let(:variables) { {} }
  # Call `result` to execute the query
  let(:result) {
    res = FreqFinderSchema.execute(
      query_string,
      context: context,
      variables: variables
    )
    # Print any errors
    if res["errors"]
      pp res
    end
    res
  }

  describe 'List stations' do
    let(:query) do
      %|{ allStations { edges { node { title }} } }|
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
      %|{ alStations { edges { node { title }} } }|
    end

    it 'returns a 200 even with an error' do
      post url, params: { query: query }
      expect(response.response_code).to eq 200
    end

    context 'no stations' do
      it 'has no errors' do
        post url, params: { query: query }
        puts "parsed_body: #{response.parsed_body.inspect}"
        expect(response.parsed_body['errors'].length).to be > 0
      end
    end
  end
end
