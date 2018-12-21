# frozen_string_literal: true

# [FreqFinderSchema]
#
# @since 20181221
# @author Joel Courtney <joel@aceteknologi.com>
class FreqFinderSchema < GraphQL::Schema
  # @!group Configuration
  # mutation Types::MutationType
  query Types::QueryType
  # @!endgroup
end
