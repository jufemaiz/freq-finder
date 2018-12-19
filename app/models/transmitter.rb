# frozen_string_literal: true

# [Transmitter]
class Transmitter < ActiveRecord::Base
  acts_as_mappable  default_units: :kilos
  belongs_to :station

  cattr_reader :per_page
  @@per_page = 10

  scope :am, -> { { conditions: %(band = "AM") } }
  scope :fm, -> { { conditions: %(band = "FM") } }
  scope :near, lambda do |*args|
    origin = *args.first[:origin]
    if origin.is_a?(Array)
      origin_lat, origin_lng = origin
    else
      origin_lat = origin.lat
      origin_lng = origin.lng
    end
    origin_lat = deg2rad(origin_lat)
    origin_lng = deg2rad(origin_lng)
    within = *args.first[:within].to_f
    within = 99_999_999 unless %w[Fixnum Float].include?(within.class)
    {
      conditions: %(
        (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(transmitters.lat))*COS(RADIANS(transmitters.lng))+
        COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(transmitters.lat))*SIN(RADIANS(transmitters.lng))+
        SIN(#{origin_lat})*SIN(RADIANS(transmitters.lat)))*6377.830272) <= #{within}
      ),
      select: %( transmitters.*,
        (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(lat))*COS(RADIANS(transmitters.lng))+
        COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(transmitters.lat))*SIN(RADIANS(transmitters.lng))+
        SIN(#{origin_lat})*SIN(RADIANS(transmitters.lat)))*6377.830272) AS distance
      )
    }
  end
end
