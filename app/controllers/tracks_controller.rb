class TracksController < ApplicationController
  def create
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
    
    #@track = Track.new(params[:track])
    #@track.user = current_user
    
    #if @track.save
      
      #redirect_to root_url
    #else
      #render :action => 'new'
    #end
  end
end
