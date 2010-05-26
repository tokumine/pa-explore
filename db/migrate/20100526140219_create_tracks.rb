class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.datetime :finished_at
      t.references :user
      t.timestamps
    end
  end
  
  def self.down
    drop_table :tracks
  end
end
