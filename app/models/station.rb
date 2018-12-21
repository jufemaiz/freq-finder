# frozen_string_literal: true

# [Station]
#
# @since 20181220
# @author Joel Courtney <joel@aceteknologi.com>
class Station < ApplicationRecord
  # @!group Relationships
  has_many :transmitters
  # @!endgroup

  # @!group Relationships
  validates :title, uniqueness: { case_sensitive: true }
  # @!endgroup
end
