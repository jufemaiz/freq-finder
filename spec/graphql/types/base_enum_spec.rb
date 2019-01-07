# frozen_string_literal: true

RSpec.describe Types::BaseEnum do
  it { expect(described_class).to be < GraphQL::Schema::Enum }
end
