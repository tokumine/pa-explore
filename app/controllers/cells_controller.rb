class CellsController < ApplicationController
  def index
    @cells = Cell.all
  end
  
  def show
    @cell = Cell.find(params[:id])
  end
  
  def new
    @cell = Cell.new
  end
  
  def create
    @cell = Cell.new(params[:cell])
    if @cell.save
      flash[:notice] = "Successfully created cell."
      redirect_to @cell
    else
      render :action => 'new'
    end
  end
  
  def edit
    @cell = Cell.find(params[:id])
  end
  
  def update
    @cell = Cell.find(params[:id])
    if @cell.update_attributes(params[:cell])
      flash[:notice] = "Successfully updated cell."
      redirect_to @cell
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @cell = Cell.find(params[:id])
    @cell.destroy
    flash[:notice] = "Successfully destroyed cell."
    redirect_to cells_url
  end
end
