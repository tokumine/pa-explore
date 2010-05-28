class Track < ActiveRecord::Base
  belongs_to :user
  has_many :classifications, :order => "position"
  has_many :cells, :through => :classifications
  attr_accessible :started_at, :finished_at, :user
  after_create :generate_track
  
  def generate_track (x=nil, y=nil)    
    @total_cells = (2**17)**2    
    @axis_max = 2**17
    
    #FOR TESTING - REPLACE WITH rand(@axis_max) later
    @x_min = 63514
    @y_min = 51214
    @x_range = 24
    @y_range = 36

  
        
    #1 Choose a random starting point    
    x ||= rand(@x_range) + @x_min #FOR TESTING - REPLACE WITH rand(@axis_max) later
    y ||= rand(@y_range) + @y_min
    z = 17
    
    APP_CONFIG[:cells_per_track].times do |i|      
      cell = Cell.find_or_create_by_x_and_y_and_z(x,y,z)      
      classifications.create(:cell => cell, :x => cell.x, :y => cell.y, :z => cell.z)
      y += 1    
    end          
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
