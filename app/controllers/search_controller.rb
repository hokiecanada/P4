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
	@search_by = params[:search_by]
	
	if @search_by == "All"
		@entries = Entry.search(@search)
	elsif @search_by == "Author"
		@entries = Entry.tagged_with(@search, :on => :authors)
	end
	
	if !@entries.nil?
		@entries = @entries.paginate	:page =>params[:page], :per_page => 5
	end
	
	respond_to do |format|
      format.html # basic.html.erb
    end
  end
  
  
  def advanced
	@search = params[:search]
	@search_by = params[:search_by]
	if params[:range].nil? || params[:range][:"year(1i)"] == ""
		@year_start = nil
		@year_end = nil
	else
		@year_start = Date.civil(params[:range][:"year(1i)"].to_i,1,1)#params[:range][:"year(2i)"].to_i,params[:range][:"year(3i)"].to_i)
		year_end = Date.civil(params[:range][:"year(1i)"].to_i,12,31)
	end
	@exp_type = params[:exp_type]
	@env_dim = params[:env_dim]
	@env_scale = params[:env_scale]
	@env_density = params[:env_density]
	@env_realism = params[:env_realism]
	@part_num = params[:part_num]
	@part_gender = params[:part_gender]
	@specificity = params[:specificity]
	
	
	if @search_by == "All" && @search != ""
		@entries = Entry.search(@search)
	elsif @search_by == "Author" && @search != ""
		@entries = Entry.tagged_with(@search, :on => :authors)
	else
		@entries = Entry.find(:all)
	end
	if !@year_start.nil?
		@entries = @entries && Entry.find(:all, :conditions => ["year >= ? and year <= ?", @year_start, year_end] )
	end
	if @exp_type != "n/a" && !@exp_type.nil?
		@entries = @entries && Entry.find_all_by_exp_type(@exp_type)
	end
	if  !@env_dim.nil? && @env_dim != "n/a"
		@entries = @entries && Entry.find_all_by_env_dim(@env_dim)
	end
	if @env_scale != "n/a" && !@env_scale.nil?
		@entries = @entries && Entry.find_all_by_env_scale(@env_scale)
	end
	if @env_density != "n/a" && !@env_density.nil?
		@entries = @entries && Entry.find_all_by_env_density(@env_density)
	end
	if @env_realism != "n/a" && !@env_realism.nil?
		@entries = @entries && Entry.find_all_by_env_realism(@env_realism)
	end
	if @part_num != "n/a" && !@part_num.nil?
		@entries = @entries && Entry.find_all_by_part_num(@part_num)
	end
	if @part_gender != "n/a" && !@part_gender.nil?
		@entries = @entries && Entry.find_all_by_part_gender(@part_gender)
	end
	if @specificity != "n/a" && !@specificity.nil?
		@entries = @entries && Entry.find_all_by_specificity(@specificity)
	end
	if !@entries.nil?
		@entries = @entries.paginate	:page =>params[:page], :per_page => 5
	end
	
	respond_to do |format|
      format.html # basic.html.erb
    end
  end
  
end