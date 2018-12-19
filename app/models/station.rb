# frozen_string_literal: true

# [Station]
class Station < ActiveRecord::Base
  has_many :transmitters
end
