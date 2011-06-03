class DownloadsController < ApplicationController
  layout false
  respond_to :csv, :json, :xml
  
  def show
    @victim = Victim.find_by_slug(params[:id], :include => :successful_visits)
    respond_with(@victim)
  end
  
end