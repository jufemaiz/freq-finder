# frozen_string_literal: true

class TransmittersController < ApplicationController
  # GET /transmitters
  # GET /transmitters.xml
  def index
    params[:page] ||= 1

    @address = nil

    if !params[:latlng].nil? && params[:latlng].match(/^(-?\d+\.\d+),(-?\d+\.\d+)$/)
      @location = Geokit::LatLng.normalize(params[:latlng])
      @address = GoogleGeocoder.reverse_geocode(@location)
      @transmitters = Transmitter.includes(:station).near(origin: @location).order('distance asc') # .paginate(:page => params[:page])
    else
      params[:s] ||= 'frequency'
      params[:d] ||= 'asc'
      @transmitters = Transmitter.includes(:station).order("#{params[:s]} #{params[:d]}") # .paginate(:page => 1)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @transmitters }
      format.json { render xml: @transmitters.to_json(include: { station: { only: [:title] } }, except: %i[created_at updated_at]) }
    end
  end

  # GET /transmitters/1
  # GET /transmitters/1.xml
  def show
    @transmitter = Transmitter.includes(:station).find(params[:id])

    if !params[:latlng].nil? && params[:latlng].match(/^(-?\d+\.\d+),(-?\d+\.\d+)$/)
      @location = Geokit::LatLng.normalize(params[:latlng].split(',')) unless params[:latlng].nil?
      @distance = @location.distance_from(Geokit::LatLng.new(@transmitter.lat, @transmitter.lng))
      # @address = GoogleGeocoder.reverse_geocode(@location)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render xml: @transmitter }
      format.json { render json: @transmitter.to_json(include: { station: { only: [:title] } }, except: %i[created_at updated_at]) }
    end
  end

  # GET /transmitters/new
  # GET /transmitters/new.xml
  def new
    @transmitter = Transmitter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @transmitter }
    end
  end

  # GET /transmitters/1/edit
  def edit
    @transmitter = Transmitter.find(params[:id])
  end

  # POST /transmitters
  # POST /transmitters.xml
  def create
    @transmitter = Transmitter.new(params[:transmitter])

    respond_to do |format|
      if @transmitter.save
        format.html { redirect_to(@transmitter, notice: 'Transmitter was successfully created.') }
        format.xml  { render xml: @transmitter, status: :created, location: @transmitter }
      else
        format.html { render action: 'new' }
        format.xml  { render xml: @transmitter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transmitters/1
  # PUT /transmitters/1.xml
  def update
    @transmitter = Transmitter.find(params[:id])

    respond_to do |format|
      if @transmitter.update_attributes(params[:transmitter])
        format.html { redirect_to(@transmitter, notice: 'Transmitter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: 'edit' }
        format.xml  { render xml: @transmitter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transmitters/1
  # DELETE /transmitters/1.xml
  def destroy
    @transmitter = Transmitter.find(params[:id])
    @transmitter.destroy

    respond_to do |format|
      format.html { redirect_to(transmitters_url) }
      format.xml  { head :ok }
    end
  end
end
