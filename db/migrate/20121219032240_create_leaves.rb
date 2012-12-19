class CreateLeaves < ActiveRecord::Migration
  def self.up
    create_table :leaves do |t|
      t.text :content
      t.timestamps
    end
  end

  def self.down
    drop_table :leaves
  end
end
