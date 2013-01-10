class AddHasTagsToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :has_tags, :boolean, :default => false
  end
end
