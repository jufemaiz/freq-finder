# frozen_string_literal: true

module Types
  # [Types::StationType]
  #
  # @since 20181220
  # @author Joel Courtney <joel@aceteknologi.com>
  class StationType < Types::BaseObject
    graphql_name 'Station'
    description 'The Station'

    field :id, ID, null: false
    field :title, String, null: false
    field :transmitters, [TransmitterType], null: true,
      description: "The Transmitters that this station is responsible for." do
      argument :location, String, required: false
    end

    def transmitters(location:)
      puts location.inspect
      super.order(frequency: :asc)
    end
  end
end
