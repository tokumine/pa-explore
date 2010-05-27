class ClassificationsController < ApplicationController
  def update
    @classification = Classification.find(params[:id])    
    if @classification.update_attributes(params[:classification]) && !current_user.tracks.include?(@classification.track)
      flash[:notice] = "Successfully updated classification."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
end
