class DropOldBadgesAndRanks < ActiveRecord::Migration
  def up
    drop_table :badges
    drop_table :ranks
  end

  def down
  end
end
