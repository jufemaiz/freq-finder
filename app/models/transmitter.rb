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

  # @!group Constants
  ANTENNA_PATTERNS = %w[DA OD]
  BANDS = %w[AM FM]
  OPERATION_HOURS = %w[day-time night-time]
  POLARISATIONS = %w[H M V]
  PURPOSES = [
    "Commercial",
    "Community",
    "HPON",
    "National",
    "Retransmission",
    "s212 Retransmission"
  ]
  STATES = %w[ACT NSW NT QLD SA TAS VIC WA]
  STATUSES = ["Issued", "Renewal Pending"]
  # @!endgroup

  # @!group Relationships
  belongs_to :station
  # @!endgroup

  # @!group Validations
  validates :antenna_height, numericality: { greater_than_or_equal_to: 0 }
  validates :antenna_pattern, inclusion: { in: ANTENNA_PATTERNS }
  validates :area, length: { minimum: 1 }
  validates :band, inclusion: { in: BANDS }
  validates :bsl, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :callsign, length: { in: 3..7 }
  validates :easting, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :frequency, numericality: { greater_than_or_equal_to: 0 }
  validates :lat, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :license_area, length: { minimum: 1 }
  validates :license_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :license_number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :lng, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :maximum_cmf, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :maximum_erp, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :northing, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :operation_hours, inclusion: { in: OPERATION_HOURS }
  validates :polarisation, inclusion: { in: POLARISATIONS }
  validates :power, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :purpose, inclusion: { in: PURPOSES }
  validates :site_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :site_name, uniqueness: { case_sensitive: true }
  validates :state, inclusion: { in: STATES }
  validates :status, inclusion: { in: STATUSES }
  validates :technical_specification_number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :zone, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # @!endgroup

  # @!group Scopes
  scope :am, -> { where(band: 'AM') }
  scope :fm, -> { where(band: 'FM') }
  # @!endgroup

  # Returns a Location for the Transmitter
  #
  # @return [Location]
  def location
    Location.normalize([lat, lng])
  end
end
