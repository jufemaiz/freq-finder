# frozen_string_literal: true

class CreateTransmitters < ActiveRecord::Migration
  def self.up
    create_table :transmitters do |t|
      t.string        :band
      t.references    :station
      t.string        :area
      t.string        :callsign
      t.float         :frequency
      t.string        :purpose
      t.string        :polarisation
      t.integer       :antenna_height
      t.string        :antenna_pattern
      t.integer       :maximum_erp
      t.integer       :maximum_cmf
      t.integer       :power
      t.integer       :technical_specification_number
      t.integer       :license_number
      t.integer       :site_id
      t.text          :site_name
      t.integer       :zone
      t.integer       :easting
      t.integer       :northing
      t.decimal       :lat, precision: 16, scale: 13
      t.decimal       :lng, precision: 16, scale: 13
      t.string        :state
      t.integer       :bsl
      t.string        :license_area
      t.integer       :license_id
      t.string        :operation_hours
      t.string        :status
      t.float         :distance

      t.timestamps
    end
  end

  def self.down
    drop_table :transmitters
  end
end
