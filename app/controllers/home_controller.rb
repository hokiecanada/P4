class HomeController < ApplicationController

  def welcome
	@recent_entries = Entry.find_all_by_status("Approved", :order => "created_at DESC")
	
	@recent_entries = @recent_entries.paginate	:page => params[:page], :per_page => 3
    respond_to do |format|
      format.html # welcome.html.erb
    end
  end
  
  def user
	authenticate_user!
	@entries = Entry.find_all_by_user_id(current_user, :order => "created_at DESC")
	@favorites = Favorite.find_all_by_user_id(current_user, :order => "created_at DESC")
	@comments = Comment.find_all_by_user_id(current_user, :order => "created_at DESC")

	@entries = @entries.paginate		:page =>params[:entries_page], :per_page => 3
	@comments = @comments.paginate		:page =>params[:comments_page], :per_page => 3
	@favorites = @favorites.paginate 	:page =>params[:favorites_page], :per_page => 3
	
	respond_to do |format|
		format.html # user.html.erb
	end
  end
  
  def admin
	authenticate_admin!
	@entries = Entry.find(:all, :order => "updated_at DESC")
	@users = User.find(:all, :order => "email")
	@entries = @entries.paginate	:page =>params[:entries_page], :per_page => 5
	@users = @users.paginate		:page =>params[:users_page], :per_page => 5
	  
	respond_to do |format|
		format.html # admin.html.erb
	end
  end

  def email_form
	authenticate_admin!
	@recipient = params[:recipient]
	@sender = params[:sender]
	@subject = ""
	@body = ""
	
	respond_to do |format|
		format.html # email_form.html.erb
		format.xml { render :xml }
	end
  end
  
  def email_send
	authenticate_admin!
	@recipient = params[:recipient]
	@subject = params[:subject]
	@body_text = params[:body_text]
	
	Emailer.send_email_to_user(params[:recipient], params[:subject], params[:body_text]).deliver
	
	redirect_to admin_root_path, :notice => 'Message was sent to the user.'
  end
end
