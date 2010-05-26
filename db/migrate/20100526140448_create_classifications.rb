class CreateClassifications < ActiveRecord::Migration
  def self.up
    create_table :classifications do |t|
      t.integer :x
      t.integer :y
      t.integer :z
      t.boolean :value, :default => nil
      t.references :track
      t.references :cell
      t.timestamps
    end
    add_index :classifications, [:x, :y, :z]
  end
  
  def self.down
    drop_table :classifications
  end
end
