# frozen_string_literal: true

class SearchController < ApplicationController
  # GET /
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /results
  # GET /results.xml
  def results
    if params[:q]
      @address = GoogleGeocoder.reverse_geocode(params[:q])
      if @address.full_address.nil?
        redirect_to root_path
      else
        redirect_to "/transmitters/?latlng=#{@address.lat},#{@address.lng}"
      end
    else
      redirect_to root_path
    end

    # respond_to do |format|
    #   format.html # index.html.erb
    # end
  end

  # GET /geolocate
  # GET /geolocate.xml
  def geolocate
    if !params[:latlng].nil? && params[:latlng].match(/^(-?\d+\.\d+),(-?\d+\.\d+)$/)
      @latlng = Geokit::LatLng.normalize(params[:latlng])
      redirect_to('/transmitters/?latlng=' + latlng)
    else
      redirect_to root_path
    end

    # respond_to do |format|
    #   format.html # index.html.erb
    # end
  end
end
