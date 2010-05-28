class MainController < ApplicationController
  before_filter :require_user, :only => [:main] 

  def index
  end
end
