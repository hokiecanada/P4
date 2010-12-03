class EntriesController < ApplicationController

  before_filter :authenticate, :only => [:new, :create]
  before_filter :authenticate_owner, :only => [:edit, :update, :destroy, :update_status, :admin_edit, :admin_update]
  
  def authenticate
	authenticate_user!
  end
  
  def authenticate_owner
	if user_signed_in?
		@user = User.find(current_user)
		@entry = current_user.entries.find(params[:id])
		
		if @entry.user_id != current_user.id
			redirect_to entry_path(@entry), :notice => 'You do not have permission to do that.'
		end
	elsif admin_signed_in?
		@user = User.find(params[:user_id])
		@entry = @user.entries.find(params[:id])
	else
		redirect_to entry_path(@entry), :notice => 'You do not have permission to do that.'
	end
  end
  
  def tag_cloud
	@tags = Entry.author_counts
  end
  
  def intro
	respond_to do |format|
      format.html # intro.html.erb
    end
  end
  
  def search
	search = Entry.search(:include => [:comments]) do
		keywords(params[:search])
	end
	@entries = search.results
	
	@entries = @entries.paginate	:page =>params[:page], :per_page => 5
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
	  format.rss { render :rss => @entries }
    end
  end
  
  # GET /entries
  # GET /entries.xml
  def index
    #@tags = Entry.author_counts
	@filter = params[:filter]
	@sort_by = params[:sort_by]
	
	if params[:search]
		@entries = Entry.search(params[:search])
	elsif @filter
		@entries = Entry.tagged_with(params[:filter])
	else
		@entries = Entry.find(:all, :order => @sort_by)
    end
	
	@entries = @entries.paginate	:page =>params[:page], :per_page => 5
	
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
	  format.rss { render :rss => @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.xml
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

  # GET /entries/new
  # GET /entries/new.xml
  def new
    #authenticate_user! 
	
	#user = User.find(params[:user_id])
    @entry = current_user.entries.build
	@systems = Array.new[System.find(:all).size]
	@components = Array.new[Component.find(:all).size]
	#redirect_to new_user_entry_path(current_user)
	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  # GET /entries/1/edit
  def edit
	@systems = Array.new[System.find(:all).size]
	@components = Array.new[Component.find(:all).size]
  end

  def admin_edit
	@systems = Array.new[System.find(:all).size]
	@components = Array.new[Component.find(:all).size]
  end
  
  # POST /entries
  # POST /entries.xml
  def create
    #user = User.find(params[:user_id])
    @entry = current_user.entries.create(params[:entry])
	@entry.viewed = 0
	@entry.status = "Pending"
	
	@systems = params[:systems]
	@systems.each do |s|
		@entry.system_list.add(s)
	end	
	
	@components = params[:components]
	@components.each do |c|
		@entry.comp_list.add(c)
	end
	
	@entry.tags_string = tasks_string(@entry) + " " + comps_string(@entry) + " " + systems_string(@entry)
	@entry.authors_string = author_string(@entry)
	
    respond_to do |format|
      if @entry.save
        format.html { redirect_to user_root_path, :notice => 'Entry was successfully created.' }
        format.xml  { render :xml => @entry, :status => :created, :location => @entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
	
	#@entry.status = "Pending"
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
        format.html { redirect_to entry_path(@entry), :notice => 'Entry was successfully updated.' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  # PUT /entries/1
  # PUT /entries/1.xml
  def admin_update
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
        format.html { redirect_to admin_root_path, :notice => 'Entry was successfully updated.' }
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
        format.html { redirect_to admin_root_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
  
    @entry.destroy

	respond_to do |format|
		if admin_signed_in?
			format.html { redirect_to admin_root_path, :notice => 'Entry was successfully deleted.' }
		else
			format.html { redirect_to user_root_path, :notice => 'Entry was successfully deleted.' }
		end
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
