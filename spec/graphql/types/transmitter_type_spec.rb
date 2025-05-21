# frozen_string_literal: true

RSpec.describe Types::TransmitterType do
  subject(:this) { described_class }

  # avail type definer in our tests
  types = GraphQL::Define::TypeDefiner.instance

  xit 'has an :id field of ID type' do
    # Ensure that the field id is of type ID
    expect(this).to have_field(:id).that_returns(!types.ID)
  end
end
