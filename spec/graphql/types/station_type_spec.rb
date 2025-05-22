# frozen_string_literal: true

RSpec.describe Types::StationType do
  subject(:this) { described_class }

  it 'has an :id field of ID type', pending: 'working out how to do this' do
    # Ensure that the field id is of type ID
    expect(this).to have_field(:id).that_returns(!GraphQL::Types::ID)
  end

  it 'has a :title field of String type', pending: 'working out how to do this' do
    # Ensure the field is of String type
    expect(this).to have_field(:title).that_returns(!GraphQL::Types::String)
  end
end
