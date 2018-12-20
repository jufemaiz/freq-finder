# frozen_string_literal: true

# [Transmitter]
#
# @since 20181220
# @author Joel Courtney <joel@aceteknologi.com>
class Transmitter < ApplicationRecord
  # @!group Acts
  acts_as_mappable default_units: :kms,
                   distance_field_name: :distance
  # @!endgroup

  # @!group Relationships
  belongs_to :station
  # @!endgroup

  # @!group Scopes
  scope :am, -> { where(band: 'AM') }
  scope :fm, -> { where(band: 'FM') }
  # @!endgroup
end
