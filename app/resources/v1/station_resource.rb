# frozen_string_literal: true

module V1
  # [V1::StationResource]
  #
  # @since 20181221
  # @author Joel Courtney <joel@aceteknologi.com>
  class StationResource < JSONAPI::Resource
    # @!group Relationships
    has_many :transmitters
    # @!endgroup

    # @!group Attributes
    attributes :created_at, :title, :updated_at
    # @!endgroup

    # @!group Class Methods
    class << self
      # Customise the sortable fields
      #
      # @param [Array<Symbol>] context
      # @return [Array<Symbol>]
      def sortable_fields(context)
        super(context)
      end
    end

    # Default sorting by the following.
    #
    # @return [Array<Hash>]
    def default_sort
      [{ field: 'title', direction: :asc }, { field: 'created', direction: :asc }]
    end
    # @!endgroup
  end
end
