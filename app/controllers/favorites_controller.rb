class FavoritesController < ApplicationController

  before_filter :get_user
  
  def get_user
	authenticate_user!
	@user = current_user
  end

  
  # POST /experiments
  # POST /experiments.xml
  def create
    @favorite = @user.favorites.create(params[:id])
	@favorite.entry_id = params[:entry_id]
	@favorite.save
	
	redirect_to entries_path, :notice => "Entry added to favorites"
  end

  
  # DELETE /experiments/1
  # DELETE /experiments/1.xml
  def destroy
    @favorite = @user.favorites.find(params[:id])
    @favorite.destroy
	
	redirect_to user_root_path
  end
  
end