# frozen_string_literal: true

# [Station]
#
# @since 20181220
# @author Joel Courtney <joel@aceteknologi.com>
class Station < ApplicationRecord
  # @!group Relationships
  has_many :transmitters, dependent: :destroy
  # @!endgroup

  # @!group Relationships
  validates :title, uniqueness: { case_sensitive: true } # rubocop:disable Rails/UniqueValidationWithoutIndex
  # @!endgroup
end
