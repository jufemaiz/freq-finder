# frozen_string_literal: true

RSpec.shared_context 'api v1 request' do
  let(:basic_headers) do
    {
      'ACCEPT' => 'application/vnd.api+json',
      'Content-Type' => 'application/vnd.api+json'
    }
  end

  let(:url) { 'http://domain.com/v1' }
end
