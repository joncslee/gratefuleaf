class AddUserIdToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :user_id, :integer
  end
end
