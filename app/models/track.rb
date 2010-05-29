class Track < ActiveRecord::Base
  belongs_to :user
  has_many :classifications, :order => "position"
  has_many :cells, :through => :classifications
  attr_accessible :started_at, :finished_at, :user
  after_create :generate_track

  # Generates a track for displaying in app. Length is set in the app_constants
  # The Explorer has the following features:
  # 
  # * Remembers path
  # * No current path overlaps (currently does not go north)
  # * Keeps within world bounds (unimplemented)
  # * Prefers unexplored tiles (unimplemented)  
  # * avoids getting into dead ends (naive walker, so not a prob)
  # * Starting position *has* to be an unexplored tile? (unimplemented)
  def generate_track (x=nil, y=nil)    

    # Can set starting location by passing {:x => x, :y => y, :z => z} hash
    explorer = Explorer.new self, :x => 63520, :y => 51220, :z => 17
    explorer.explore!                    
  end
  
  def game_json    
    json = []      
    classifications.each do |c|
      surprise = rand < 0.5 ? "true" : "false"
      json << { :id => c.id,
                :x  => c.x,
                :y  => c.y,
                :z  => c.z,
                :surprise => surprise}
    end
    json
  end
end
