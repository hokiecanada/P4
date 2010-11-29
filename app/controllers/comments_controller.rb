class CommentsController < ApplicationController

  before_filter(:get_entry)
  
  def get_entry
	@entry = Entry.find(params[:entry_id])
  end

  
  # POST /experiments
  # POST /experiments.xml
  def create
    authenticate_user!
    @comment = @entry.comments.create(params[:comment])
	@comment.user_id = current_user.id
	@comment.save
	
	if @entry.user_id = current_user.id
		redirect_to user_entry_path(current_user, @entry)
	else
		redirect_to entry_path(@entry)
	end
  end

  
  # DELETE /experiments/1
  # DELETE /experiments/1.xml
  def destroy
    @comment = @entry.comments.find(params[:id])
    @comment.destroy
	
	if @entry.user_id = current_user.id
		redirect_to user_entry_path(current_user, @entry)
	else
		redirect_to entry_path(@entry)
	end
  end
  
end