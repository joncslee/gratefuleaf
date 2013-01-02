class AddGoalTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :goal_type, :integer, :default => 0
  end
end
