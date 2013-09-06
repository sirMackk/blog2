class UploadsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @urls = Upload.where(:post_id == params[:post_id]).collect do |i|
      [i.id, i.asset.url, i.asset.url(:thumb),]
    end
    respond_to do |f|
      f.json { render json: @urls }
    end
  end

  def create
    params[:upload].each do |file|
      tmp = {}
      tmp[:asset] = file
      # move this to model
      upload = Upload.new tmp
      upload.post_id = params[:post_id]
      upload.title = file.original_filename
      render json: { error: "Upload error" } unless upload.save
    end
    @uploads = []
    Post.find(params[:post_id]).uploads.each do |upload|
      @uploads << upload.asset.url
    end
    respond_to do |f|
      f.json { render json:  @uploads }
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    if @upload.destroy
      render json: "Success"
    else
      render json: { error: "Upload delete error" }
    end
  end

end