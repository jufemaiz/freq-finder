# frozen_string_literal: true

# [StationsController]
#
# @since 20181220
# @author Joel Courtney <joel@aceteknologi.com>
class StationsController < ApplicationController
  before_action :set_station, only: [:show]

  # GET /stations
  def index
    @stations = Station.all
  end

  # GET /stations/:id
  def show; end

  private

  def set_station
    @station = Station.find(params[:id])
  end
end
