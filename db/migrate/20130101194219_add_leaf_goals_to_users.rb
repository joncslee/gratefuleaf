class AddLeafGoalsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :daily_leaf_goal, :integer
    add_column :users, :weekly_leaf_goal, :integer
  end
end
