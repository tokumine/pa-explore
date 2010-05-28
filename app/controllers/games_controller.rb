class GamesController < ApplicationController
  before_filter :require_user, :only => [:index] 

  layout false
    
  def index
    
  end
end
