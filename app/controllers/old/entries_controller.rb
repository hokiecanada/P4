class EntriesController < ApplicationController

  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  
  def authenticate
	authenticate_user!
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
		#@entries = search.results
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




end
