class JaviController < ApplicationController
  def new_track
    x = 63484
    y = 51212
    id = 1    
    json = []
    
    APP_CONFIG[:cells_per_track].times do |i|
      json << { :id => i,
                :x => x,
                :y => y+i,
                :count => rand(20)}
    end            
    render  :json => json          
  end
  
  def get_cells_by_tile
    
  end
end
