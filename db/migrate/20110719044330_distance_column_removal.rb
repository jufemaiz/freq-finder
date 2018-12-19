# frozen_string_literal: true

class DistanceColumnRemoval < ActiveRecord::Migration
  def self.up
    remove_column :transmitters, :distance
  end

  def self.down
    add_column :transmitters, :distance
  end
end
