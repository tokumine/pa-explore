class JaviController < ApplicationController
  #max 262144
  #top left origin
  def new_track
    x = 63484
    y = 51212
    id = 1    
    json = []
    
    APP_CONFIG[:cells_per_track].times do |i|
      surprise = rand() < 0.5 ? "true" : "false"
      json << { :id => i,
                :x => x,
                :y => y+i,
                :z => 17
                :surprise => surprise}
    end            
    render  :json => json          
  end
  
  def get_cells_by_tile
    
  end
end
