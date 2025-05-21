# frozen_string_literal: true

# [CreateStations]
#
# @since 20181220
# @author Joel Courtney <joel@aceteknologi.com>
class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.string :title, index: { unique: true, name: index_stations_on_title }

      t.timestamps
    end
  end
end
