class AdminFormController < ApplicationController
  def edit
    authenticate_admin! 
	
    respond_to do |format|
      format.html # edit.html.erb
      format.xml  { render :xml }
    end
  end
end