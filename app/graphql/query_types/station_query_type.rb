# frozen_string_literal: true

module QueryTypes
  # [QueryTypes::StationQueryType]
  #
  # @since 20181221
  # @author Joel Courtney <joel@aceteknologi.com>
  class StationQueryType < GraphQL::Schema::Object
    graphql_name 'StationQueryType'
    description 'The Station Query Type'

    field :stations, Types::StationType, null: true, description: ''

    def stations(_obj, _args, _ctx)
      Station.all
    end
  end
end
