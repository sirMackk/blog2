class Upload < ActiveRecord::Base

    belongs_to :post

    has_attached_file :asset, :styles => { :thumb => "350x350" }
    before_post_process :image?


    def image?
        !(asset_content_type =~ /^image.*/).nil?
    end

end