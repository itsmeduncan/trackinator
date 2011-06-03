class VictimsController < ApplicationController
  
  def index
    @victims = Victim.all(:include => [:visits, :unsuccessful_visits, :successful_visits])
  end
  
  def show
    @victim = Victim.find_by_slug(params[:id], :include => [:visits, :unsuccessful_visits, :successful_visits])
  end
  
end
