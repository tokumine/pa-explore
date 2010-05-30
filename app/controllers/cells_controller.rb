class CellsController < ApplicationController
  def tiles
    cells = Cell.all :conditions => "parent_x = #{params[:x]} AND parent_y = #{params[:y]} AND parent_z = #{params[:z]}"
    json = cells.inject([]) { |a,c| a << c.game_json }
    render :json => json, :callback => params[:callback]    
  end  
end
