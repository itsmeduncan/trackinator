class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
    def can_edit
      redirect_to root_path unless ["development", "test"].include?(Rails.env)
    end
end
