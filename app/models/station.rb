# frozen_string_literal: true

class Station < ActiveRecord::Base
  has_many :transmitters
end
