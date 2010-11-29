class EntriesController < ApplicationController

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
		search = Entry.search(:include => [:comments]) do
			keywords(params[:search])
		end
		@entries = search.results
	elsif @filter
		@entries = Entry.tagged_with(params[:filter], :order => @sort_by)
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
    authenticate_user! 
	user = User.find(params[:user_id])
    @entry = user.entries.build
	@systems = Array.new[System.find(:all).size]
	@components = Array.new[Component.find(:all).size]
	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    user = User.find(params[:user_id])
    @entry = @user.entries.find(params[:id])
	@systems = Array.new[System.find(:all).size]
	@components = Array.new[Component.find(:all).size]
  end

  # POST /entries
  # POST /entries.xml
  def create
    user = User.find(params[:user_id])
    @entry = user.entries.create(params[:entry])
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
	
    respond_to do |format|
      if @entry.save
        format.html { redirect_to entry_path(@entry), :notice => 'Entry was successfully created.' }
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
    user = User.find(params[:user_id])
    @entry = user.entries.find(params[:id])
	
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

  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    user = User.find(params[:user_id])
    @entry = user.entries.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to(entries_url) }
      format.xml  { head :ok }
    end
  end
end
