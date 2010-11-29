class SystemsController < ApplicationController
  
  # POST /experiments
  # POST /experiments.xml
  def create
    authenticate_admin!
    @system = System.create(params[:system])
	@system.save
	redirect_to admin_session_path
  end

  
  # DELETE /experiments/1
  # DELETE /experiments/1.xml
  def destroy
    @system = System.find(params[:id])
    @system.destroy
	redirect_to admin_session_path
  end
  
end