class TasksController < ApplicationController
  
  # POST /experiments
  # POST /experiments.xml
  def create
    authenticate_admin!
    @task = Task.create(params[:task])
	@task.save
	redirect_to admin_session_path
  end

  
  # DELETE /experiments/1
  # DELETE /experiments/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
	redirect_to admin_session_path
  end
  
end