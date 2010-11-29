class HomeController < ApplicationController

  def welcome
    respond_to do |format|
      format.html # welcome.html.erb
    end
  end
  
  def user
	@entries = current_user.entries
	#@saved = Entry.find
	respond_to do |format|
		format.html # user.html.erb
	end
  end
  
  def admin
  @entries = Entry.find(:all, :order => "updated_at DESC")
  @users = User.find(:all, :order => "email")
	respond_to do |format|
		format.html # admin.html.erb
	end
  end

end
