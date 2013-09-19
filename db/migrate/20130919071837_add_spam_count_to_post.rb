class AddSpamCountToPost < ActiveRecord::Migration
  def change
    add_column :posts, :spam_count, :integer, null: false, default: 0
  end
end
