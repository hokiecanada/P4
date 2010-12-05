class CommentsController < ApplicationController

  before_filter :get_entry, :only => [:create, :destroy]
  
  def get_entry
	@entry = Entry.find(params[:entry_id])
  end

  
  def create
	if user_signed_in?
		@comment = @entry.comments.create(params[:comment])
		@comment.user_id = current_user.id
		@comment.save
	
		Emailer.comment_added(User.find(@entry.user_id).email, @entry, @comment).deliver
		Emailer.admin_comment_added("cstinson@vt.edu", @entry, @comment).deliver
		redirect_to entry_path(@entry)
	else
		redirect_to new_user_session_path, :notice => 'You must be signed in to comment on entries. Please sign in or create a new account.'
	end		
  end

  
  def destroy
    if @comment.user_id == current_user.id
		@comment = @entry.comments.find(params[:id])
		@comment.destroy
	
		redirect_to entry_path(@entry)
	else
		redirect_to entry_path(@entry), :notice => 'You must be the owner to delete this comment.'
	end
  end
  
end