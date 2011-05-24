class VictimsController < ApplicationController
  
  def index
    @victims = Victim.all(:include => :visits)
  end
  
end
