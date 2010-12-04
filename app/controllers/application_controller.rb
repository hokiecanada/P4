class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  
  before_filter :set_timezone
  before_filter :get_search
  
  def set_timezone
    if user_signed_in?
		Time.zone = current_user.time_zone
	elif admin_signed_in?
		Time.zone = current_admin.time_zone
	else
		Time.zone = "Eastern Time (US & Csnada)"
	end
  end
  
  def get_search
	@search = params[:search]
  end
	
end
