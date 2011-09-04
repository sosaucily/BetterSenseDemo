class IqeinfosController < ApplicationController

  def processme
    @video = Video.find(params[:video_id])
    logger.info "Process ME called!"
    qid_data = params[:qid_data]
    logger.info qid_data
    @iqeinfo = @video.iqeinfos.find(params[:id])
    labels = ""
    qid_data.each do |qid|
      labels += qid[:labels] + " | "
    end
    color = qid_data[0][:color]
    @iqeinfo.matcheditem = labels
    @iqeinfo.colors = color
    @iqeinfo.save
    redirect_to videos_url+'/' + params[:video_id].to_s + '/iqeinfos/' + params[:id]
  end


  def show
    @video = Video.find(params[:video_id])
    @iqeinfo = @video.iqeinfos.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @iqeinfo }
    end
  end

  def index
    @video = Video.find(params[:video_id])
    @iqeinfos = @video.iqeinfos.ordered.paginate :page => params[:page], :per_page => 10 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @iqeinfos }
      format.js
    end
  end

  def edit
    @video = Video.find(params[:video_id])
    @iqeinfo = @video.iqeinfos.find(params[:id])
  end

  # PUT /videos/1/iqeinfos/1
  # PUT /videos/1/iqeinfos/1.xml
  def update
    @video = Video.find(params[:video_id])
    @iqeinfo = @video.iqeinfos.find(params[:id])

    respond_to do |format|
      if @iqeinfo.update_attributes(params[:iqeinfo])
        logger.info 'Updating IQEINFO with id ' + params[:id].to_s
        format.html { redirect_to(videos_path + "/" + @iqeinfo.video_id.to_s + '/iqeinfos/' + @iqeinfo.id.to_s, :notice => 'iqeinfo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ieqinfo.errors, :status => :unprocessable_entity }
      end
    end
  end

  def create
     logger.info 'Processing Images for a video'
    @video = Video.find(params[:video_id])
#    @iqeinfo = @video.iqeinfos.create(params[:iqeinfo])
    processResults = process_video(@video)
    logger.info 'Results from processing is ' + processResults
    redirect_to video_path(@video)
  end

end
