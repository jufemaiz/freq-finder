# frozen_string_literal: true

RSpec.describe Types::StationType do
  subject(:this) { described_class }

  # avail type definer in our tests
  types = GraphQL::Define::TypeDefiner.instance

  xit 'has an :id field of ID type' do
    # Ensure that the field id is of type ID
    expect(this).to have_field(:id).that_returns(!types.ID)
  end

  xit 'has a :title field of String type' do
    # Ensure the field is of String type
    expect(this).to have_field(:title).that_returns(!types.String)
  end
end
