# frozen_string_literal: true

# [Transmitter]
#
# @since 20181220
# @author Joel Courtney <joel@aceteknologi.com>
class Transmitter < ApplicationRecord
  acts_as_mappable
  # @!group Relationships
  belongs_to :station
  # @!endgroup
end
