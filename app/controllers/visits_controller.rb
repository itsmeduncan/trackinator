class VisitsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @victim = Victim.find(params[:victim_id])
    
    if request.delete? && @victim.editable_by(current_user)
      @victim.visits.delete_all
      redirect_to victim_path(@victim)
    end
  end
  
end
