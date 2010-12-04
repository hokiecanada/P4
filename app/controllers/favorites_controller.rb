class FavoritesController < ApplicationController

  before_filter :authenticate_user!
  
  def create
    @favorite = current_user.favorites.create(params[:id])
	@favorite.entry_id = params[:entry_id]
	@favorite.save
	
	redirect_to entries_path, :notice => "Entry added to favorites"
  end

  
  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @favorite.destroy
	
	redirect_to user_root_path
  end
  
end