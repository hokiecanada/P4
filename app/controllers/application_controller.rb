class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  has_mobile_fu
  
  before_filter :get_search
  
  def get_search
	@search = params[:search]
  end
	
end
