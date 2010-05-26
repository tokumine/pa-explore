class CreateCells < ActiveRecord::Migration
  def self.up
    create_table :cells do |t|
      t.integer :positive_count, :default => 0
      t.integer :negative_count, :default => 0
      t.integer :x
      t.integer :y
      t.integer :z
      t.integer :parent_x
      t.integer :parent_y
      t.integer :parent_z
      t.timestamps
    end
    add_index :cells, [:x, :y, :z]
    add_index :cells, [:parent_x, :parent_y, :parent_z]
  end
  
  def self.down
    drop_table :cells
  end
end
