# frozen_string_literal: true

RSpec.describe Types::BaseUnion do
  it { expect(described_class).to be < GraphQL::Schema::Union }
end
