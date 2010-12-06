class FavoritesController < ApplicationController

  #before_filter :authenticate_user!
  
  
  def create
	if user_signed_in?
		@favorite = current_user.favorites.create(params[:favorite])
		@favorite.user_id = current_user.id
		@favorite.save
		entry = Entry.find(@favorite.entry_id)
	
		redirect_to entry_path(entry), :notice => 'Entry added to favorites'
	else
		redirect_to new_user_session_path, :notice => 'You must be signed in to add favorites. Please sign in or create a new account.'
	end
  end

  
  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @favorite.destroy
	
	redirect_to user_root_path, :notice => 'Entry has been removed.'
  end
  
end