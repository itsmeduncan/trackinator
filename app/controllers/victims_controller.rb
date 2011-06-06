class VictimsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @my_victims = current_user.victims.order("created_at DESC") rescue []
    
    @recent_victims = Victim.order("created_at DESC").limit(5).all(:include => [:visits, :unsuccessful_visits, :successful_visits])
    @recent_visits = Visit.successful.limit(5).order("created_at DESC").all(:include => :victim)
  end
  
  def show
    @victim = Victim.find_by_slug!(params[:id], :include => [:visits, :unsuccessful_visits, :successful_visits])
  end
  
  def new
    @victim = Victim.new
  end
  
  def create
    @victim = Victim.new(params[:victim])
    @victim.user_id = current_user.id
    
    if @victim.save
      redirect_to victim_path(@victim.to_param)
    else
      render :new
    end
  end
  
  def edit
    @victim = Victim.find_by_slug!(params[:id]).becomes(Victim)
    
    unless @victim.editable_by(current_user)
      flash[:notice] = "You don't have the permissions to do that"
      redirect_to root_path and return
    end
  end
  
  def update
    @victim = Victim.find_by_slug!(params[:id])
    
    unless @victim.editable_by(current_user)
      flash[:notice] = "You don't have the permissions to do that"
      redirect_to root_path and return
    else
      if @victim.update_attributes(params[:victim])
        redirect_to victim_path(@victim.to_param)
      else
        render :edit
      end
    end
  end
  
  def destroy
    @victim = Victim.find_by_slug!(params[:id])
    
    unless @victim.editable_by(current_user)
      flash[:notice] = "You don't have the permissions to do that"
      redirect_to root_path and return
    else
      @victim.destroy
      redirect_to root_path
    end
  end

end
