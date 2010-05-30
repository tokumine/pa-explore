class AddIndexToUserRank < ActiveRecord::Migration
  def self.up
    add_index :users, :rank
  end

  def self.down
    remove_index :users, :rank
  end
end
