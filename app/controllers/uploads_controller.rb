class UploadsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @urls = Upload.where(post_id: params[:post_id]).collect do |i|
      if i.asset_content_type =~ /^image.*/
        thumb = i.asset.url(:thumb)
      else
        thumb = "/assets/Box.png"
      end
      [i.id, i.asset.url, thumb]
    end
    render json: @urls
  end

  def create
    @uploads = []
    params[:upload].each do |file|
      tmp = {}
      tmp[:asset] = file
      # TODO: move this to model, FAT controller!
      upload = Upload.new tmp
      upload.post_id = params[:post_id]
      upload.title = file.original_filename
      render json: { error: "Upload error" } unless upload.save
      @uploads << upload.asset.url
    end
    render json: @uploads
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