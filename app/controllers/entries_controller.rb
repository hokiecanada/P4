class EntriesController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :authenticate_owner, :only => [:edit, :update, :destroy]
  
  def authenticate_owner
	@user = User.find(current_user)
	@entry = current_user.entries.find(params[:id])
		
	if @entry.user_id != current_user.id
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


  def new
    @entry = current_user.entries.build
	@systems = Array.new[System.find(:all).size]
	@components = Array.new[Component.find(:all).size]
	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entry }
    end
  end


  def edit
	@systems = Array.new[System.find(:all).size]
	@components = Array.new[Component.find(:all).size]
  end

  
  def create
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
	@entry.authors_string = authors_string(@entry)
	
    respond_to do |format|
      if @entry.save
		Emailer.entry_received(current_user.email, @entry).deliver
		Emailer.admin_entry_added('cstinson@vt.edu', @entry).deliver
        format.html { redirect_to user_root_path, :notice => 'Entry was successfully created.' }
        format.xml  { render :xml => @entry, :status => :created, :location => @entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
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
	@entry.authors_string = authors_string(@entry)
	
    respond_to do |format|
      if @entry.update_attributes(params[:entry])
		Emailer.entry_updated(current_user.email, @entry).deliver
		Emailer.admin_entry_updated('cstinson@vt.edu', @entry).deliver
        format.html { redirect_to entry_path(@entry), :notice => 'Entry was successfully updated.' }
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
		format.html { redirect_to user_root_path, :notice => 'Entry was successfully deleted.' }
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
  

  def authors_string(entry)
	return "" unless entry.author_list.any?
	authors = entry.author_list.collect do |tag|
		tag
	end
	authors_string = authors.join(' ')
  end
end
