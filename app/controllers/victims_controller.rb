class VictimsController < ApplicationController
  before_filter :can_edit, :except => [:index, :show]
  
  def index
    @victims = Victim.all(:include => [:visits, :unsuccessful_visits, :successful_visits])
    @recent_visits = Visit.successful.limit(5).order(:created_at).all(:include => :victim)
  end
  
  def show
    @victim = Victim.find_by_slug(params[:id], :include => [:visits, :unsuccessful_visits, :successful_visits])
  end
  
  def new
    @victim = Victim.new
  end
  
  def create
    @victim = Victim.new(params[:victim])
    if @victim.save
      redirect_to victim_path(@victim.to_param)
    else
      render :new
    end
  end
  
  def edit
    @victim = Victim.find_by_slug(params[:id]).becomes(Victim)
  end
  
  def update
    @victim = Victim.find_by_slug(params[:id])
    if @victim.update_attributes(params[:victim])
      redirect_to victim_path(@victim.to_param)
    else
      render :edit
    end
  end
  
  def destroy
    @victim = Victim.find_by_slug(params[:id])
    @victim.destroy
    redirect_to root_path
  end
  
end
