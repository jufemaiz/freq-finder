# frozen_string_literal: true

RSpec.describe Types::BaseScalar do
  it { expect(described_class).to be < GraphQL::Schema::Scalar }
end
