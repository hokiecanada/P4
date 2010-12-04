class AdminEntriesController < ApplicationController

  before_filter :authenticate_admin!
  before_filter :find_user, :only => [:edit, :update, :destroy, :update_status]
  
  def find_user
	@user = User.find(params[:user_id])
	@entry = @user.entries.find(params[:id])
  end
  
  
  def index
	@sort_by = params[:sort_by]
	@entries = Entry.find(:all, :order => @sort_by)
	@entries = @entries.paginate	:page =>params[:page], :per_page => 20
	
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
	  format.rss { render :rss => @entries }
    end
  end


  def show
    @entry = Entry.find(params[:id])
	@entry.viewed += 1
	@entry.update_attributes(params[:id])
	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entry }
	  format.rss { render :rss => @entry }
    end
  end


  def edit
	@systems = Array.new[System.find(:all).size]
	@components = Array.new[Component.find(:all).size]
  end


  def update
	@entry.status = "Pending"
	@entry.system_list = ""
	@systems = params[:systems]
	@systems.each do |s|
		@entry.system_list.add(s)
	end	
	
	@entry.comp_list = ""
	@components = params[:components]
	@components.each do |c|
		@entry.comp_list.add(c)
	end
	
	@entry.tags_string = tasks_string(@entry) + " " + comps_string(@entry) + " " + systems_string(@entry)
	@entry.authors_string = author_string(@entry)
	
    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to admin_entry_path(@entry), :notice => 'Entry was successfully updated.' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  def update_status	
    respond_to do |format|
      if @entry.update_attributes(params[:entry])
		if @entry.status == "Approved"
			Emailer.entry_approved(User.find(@entry.user_id).email).deliver
		end
        format.html { redirect_to admin_root_path, :notice => 'Entry status updated.' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  def destroy
    @entry.destroy
	respond_to do |format|
		format.html { redirect_to admin_root_path, :notice => 'Entry was successfully deleted.' }
	end
  end
  
  
  def tasks_string(entry)
	return "" unless entry.task_list.any?
	tasks = entry.task_list.collect do |tag|
		tag
	end
	tasks_string = tasks.join(' ')
  end

  
  def comps_string(entry)
	return "" unless entry.comp_list.any?
	comps = entry.comp_list.collect do |tag|
		tag
	end
	comps_string = comps.join(' ')
  end
  

  def systems_string(entry)
	return "" unless entry.system_list.any?
	systems = entry.system_list.collect do |tag|
		tag
	end
	systems_string = systems.join(' ')
  end
  

  def author_string(entry)
	return "" unless entry.author_list.any?
	authors = entry.author_list.collect do |tag|
		tag
	end
	authors_string = authors.join(' ')
  end
end
