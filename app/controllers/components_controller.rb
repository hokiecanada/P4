class ComponentsController < ApplicationController
  
  # POST /experiments
  # POST /experiments.xml
  def create
    authenticate_admin!
    @component = Component.create(params[:component])
	@component.save
	redirect_to admin_session_path
  end

  
  # DELETE /experiments/1
  # DELETE /experiments/1.xml
  def destroy
    @component = Component.find(params[:id])
    @component.destroy
	redirect_to admin_session_path
  end
  
end