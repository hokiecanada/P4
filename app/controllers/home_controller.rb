class HomeController < ApplicationController

  def welcome
	@recent_entries = Entry.find_all_by_status("Approved", :order => "created_at DESC")
	
	@recent_entries = @recent_entries.paginate	:page => params[:page], :per_page => 3
    respond_to do |format|
      format.html # welcome.html.erb
    end
  end
  
  def user
	@entries = Entry.find_all_by_user_id(current_user)
	@favorites = Favorite.find_all_by_user_id(current_user)
	@comments = Comment.find_all_by_user_id(current_user)

	@entries = @entries.paginate		:page =>params[:entries_page], :per_page => 5
	@comments = @comments.paginate		:page =>params[:comments_page], :per_page => 5
	@favorites = @favorites.paginate 	:page =>params[:favorites_page], :per_page => 5
	
	respond_to do |format|
		format.html # user.html.erb
	end
  end
  
  def admin
  @entries = Entry.find(:all, :order => "updated_at DESC")
  @users = User.find(:all, :order => "email")
  @entries = @entries.paginate	:page =>params[:entries_page], :per_page => 5
  @users = @users.paginate		:page =>params[:users_page], :per_page => 5
  
	respond_to do |format|
		format.html # admin.html.erb
	end
  end

end
