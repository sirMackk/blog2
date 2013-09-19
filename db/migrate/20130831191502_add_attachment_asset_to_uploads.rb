class AddAttachmentAssetToUploads < ActiveRecord::Migration
  def self.up
    change_table :uploads do |t|
      t.attachment :asset
    end
  end

  def self.down
    drop_attached_file :uploads, :asset
  end
end
