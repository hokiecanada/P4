class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  
  before_filter(:get_search)
  
  def get_search
	@search = params[:search]
  end
	
end
