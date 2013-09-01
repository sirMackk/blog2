class Upload < ActiveRecord::Base

    belongs_to :post

    has_attached_file :asset, :styles => { :thumb => "350x350" }

end