class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :title
      t.references :post
      t.timestamps
    end

    add_index :uploads, :post_id
  end
end
