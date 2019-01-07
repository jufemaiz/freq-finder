# frozen_string_literal: true

RSpec.describe Types::BaseInputObject do
  it { expect(described_class).to be < GraphQL::Schema::InputObject }
end
