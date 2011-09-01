class AdSetsController < ApplicationController
  # GET /ad_sets
  # GET /ad_sets.xml
  def index
    @ad_sets = AdSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ad_sets }
    end
  end

  # GET /ad_sets/1
  # GET /ad_sets/1.xml
  def show
    @ad_set = AdSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ad_set }
    end
  end

  # GET /ad_sets/new
  # GET /ad_sets/new.xml
  def new
    @ad_set = AdSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ad_set }
    end
  end

  # GET /ad_sets/1/edit
  def edit
    @ad_set = AdSet.find(params[:id])
  end

  # POST /ad_sets
  # POST /ad_sets.xml
  def create
    @ad_set = AdSet.new(params[:ad_set])

    respond_to do |format|
      if @ad_set.save
        format.html { redirect_to(@ad_set, :notice => 'Ad set was successfully created.') }
        format.xml  { render :xml => @ad_set, :status => :created, :location => @ad_set }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ad_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ad_sets/1
  # PUT /ad_sets/1.xml
  def update
    @ad_set = AdSet.find(params[:id])

    respond_to do |format|
      if @ad_set.update_attributes(params[:ad_set])
        format.html { redirect_to(@ad_set, :notice => 'Ad set was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ad_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ad_sets/1
  # DELETE /ad_sets/1.xml
  def destroy
    @ad_set = AdSet.find(params[:id])
    @ad_set.destroy

    respond_to do |format|
      format.html { redirect_to(ad_sets_url) }
      format.xml  { head :ok }
    end
  end
end
