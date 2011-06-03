class VictimsController < ApplicationController
  
  def index
    @victims = Victim.all(:include => :visits)
  end
  
  def show
    @victim = Victim.find_by_slug(params[:id], :include => :visits)
  end
  
end
