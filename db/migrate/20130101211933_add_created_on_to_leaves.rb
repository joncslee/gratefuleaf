class AddCreatedOnToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :created_on, :date
    add_column :leaves, :updated_on, :date
  end
end
