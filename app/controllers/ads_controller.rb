class AdsController < ApplicationController

  def regclick
    @ad = Ad.find(params[:id])
    curr_count = @ad.click_count || 0
    @ad.click_count = curr_count + 1
    @ad.save
    redirect_to params[:url]
  end    

  def regimpress
    @ad = Ad.find(params[:id])
    curr_count = @ad.impress_count || 0
    @ad.impress_count = curr_count + 1
    @ad.save
    head :ok
  end

  # GET /ads
  # GET /ads.xml
  def index
    @ads = Ad.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ads }
    end
  end

  # GET /ads/1
  # GET /ads/1.xml
  def show
    @ad = Ad.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ad }
    end
  end

  # GET /ads/new
  # GET /ads/new.xml
  def new
    @ad = Ad.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ad }
    end
  end

  # GET /ads/1/edit
  def edit
    @ad = Ad.find(params[:id])
  end

  # POST /ads
  # POST /ads.xml
  def create
    @ad = Ad.new(params[:ad])
    respond_to do |format|
      if @ad.save
        format.html { redirect_to(@ad, :notice => 'Ad was successfully created.') }
        format.xml  { render :xml => @ad, :status => :created, :location => @ad }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ads/1
  # PUT /ads/1.xml
  def update
    @ad = Ad.find(params[:id])
    @nfo = params[:ad][:nfo]
    params[:ad].delete :nfo
    respond_to do |format|
      if @ad.update_attributes(params[:ad])
        format.html { redirect_to(@ad, :notice => 'Ad was successfully updated.') }
        format.xml  { head :ok }
        format.js   
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.xml
  def destroy
    @ad = Ad.find(params[:id])
    @ad.destroy

    respond_to do |format|
      format.html { redirect_to(ads_url) }
      format.xml  { head :ok }
    end
  end
end
