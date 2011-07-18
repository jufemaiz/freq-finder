class TransmittersController < ApplicationController
  # GET /transmitters
  # GET /transmitters.xml
  def index
    params[:page] ||= 1
    
    if params[:latlng].nil?
      @transmitters = Transmitter.limit(100).paginate(:page => 1)
    # elsif !params[:band].nil?
    #   @transmitters = Transmitter.near(:origin => params[:latlng].split(',')).order('distance asc').paginate(:page => params[:page])
    else
      @transmitters = Transmitter.near(:origin => params[:latlng].split(',')).order('distance asc').paginate(:page => params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transmitters }
    end
  end

  # GET /transmitters/1
  # GET /transmitters/1.xml
  def show
    @transmitter = Transmitter.includes(:station).find(params[:id])
    
    @location = Geokit::LatLng.new(params[:latlng].split(',')) unless params[:latlng].nil?
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transmitter }
      format.json { render :json => @transmitter.to_json( :include => { :station => { :only => [:title] } }, :except => [ :created_at, :updated_at ] ) }
    end
  end

  # GET /transmitters/new
  # GET /transmitters/new.xml
  def new
    @transmitter = Transmitter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transmitter }
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
        format.html { redirect_to(@transmitter, :notice => 'Transmitter was successfully created.') }
        format.xml  { render :xml => @transmitter, :status => :created, :location => @transmitter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @transmitter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /transmitters/1
  # PUT /transmitters/1.xml
  def update
    @transmitter = Transmitter.find(params[:id])

    respond_to do |format|
      if @transmitter.update_attributes(params[:transmitter])
        format.html { redirect_to(@transmitter, :notice => 'Transmitter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transmitter.errors, :status => :unprocessable_entity }
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
