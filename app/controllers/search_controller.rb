class SearchController < ApplicationController

  before_filter :tag_cloud
  
  
  def tag_cloud
	@tags = (Entry.tag_counts_on(:authors) + Entry.tag_counts_on(:comps) + Entry.tag_counts_on(:systems) + Entry.tag_counts_on(:tasks)).sort_by {rand}
  end
  
  
  def index
	
	respond_to do |format|
		format.html # index.html.erb
	end
  end

  
  def tag
	if params[:tag]
		@entries = Entry.tagged_with(params[:tag])
	end
	@entries = @entries.paginate	:page =>params[:page], :per_page => 5
	
	respond_to do |format|
      format.html # show.html.erb
    end
  end  
  
  
  def basic
	@search = params[:search]
	temp = Entry.search(:include => [:comments]) do
		keywords(params[:search])
	end
	@entries = temp.results
	@entries = @entries.paginate	:page =>params[:page], :per_page => 5
	
	respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  
  def advanced
	
  end
  
end