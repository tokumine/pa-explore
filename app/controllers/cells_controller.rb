class CellsController < ApplicationController
  def tiles
    cells = Cell.find_all_by_parent_x_and_parent_y_and_parent_z(params[:x],params[:y],params[:z])    
    json = cells.inject([]) { |a,c| a << c.game_json }
    render :json => json, :callback => params[:callback]    
  end  
end
