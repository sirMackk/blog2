class UploadsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @files = Upload.where(:post_id == params[:post_id])
    respond_to do |f|
      f.json { render json: @files }
    end
  end

  def create
    params[:upload].each do |file|
      tmp = {}
      tmp[:asset] = file
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
  end

end