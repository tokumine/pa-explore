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
  # * No path overlaps
  # * Keeps within world bounds
  # * Prefers unexplored tiles  
  # * Starting position *has* to be an unexplored tile?
  def generate_track (x=nil, y=nil)    
    # FOR TESTING - REPLACE WITH rand(@axis_max) later
    # @x_min = 63514
    # @y_min = 51214
    # @x_range = 24
    # @y_range = 36

    # Can set starting location by passing {:x => x, :y => y, :z => z} hash
    y = 51220
    APP_CONFIG[:cells_per_track].times do 
      cell = Cell.find_or_create_by_x_and_y_and_z(63520,y,17)
      classifications.create(:cell => cell, :x => cell.x, :y => cell.y, :z => cell.z)      
      y +=1
    end
    
    #explorer = Explorer.new :x => 63520, :y => 51220, :z => 17
    #explorer.explore                    
  end
  
  def game_json    
    json = []      
    classifications.each do |c|
      surprise = rand < 0.5 ? "true" : "false"
      json << { :id => c.id,
                :x => c.x,
                :y => c.y,
                :z => c.z,
                :surprise => surprise}
    end
    json
  end
end
