class SearchController < ApplicationController


  def tag
	@entries = Entry.find_all_by_status("Approved") & Entry.tagged_with(params[:tag])
	
	if @entries.nil?
		@found = "0 results found"
	elsif @entries.size == 1
		@found = "1 result found"
	else
		@found = @entries.size.to_s + " results found."
	end

	if !@entries.nil?
		@entries = @entries.paginate	:page =>params[:page], :per_page => 5
	end
	
	respond_to do |format|
      format.html # tag.html.erb
    end
  end  
  
  
  def basic
	@keyword = params[:keyword]
	
	if !@keyword.nil? && @keyword != "" 
		@entries = Entry.find_all_by_status("Approved") & Entry.search(@keyword)
	else
		@entries = nil
	end
	
	if @entries.nil?
		@found = "0 results found"
	elsif @entries.size == 1
		@found = "1 result found"
	else
		@found = @entries.size.to_s + " results found."
	end

	if !@entries.nil?
		@entries = @entries.paginate	:page =>params[:page], :per_page => 5
	end
	
	respond_to do |format|
      format.html # basic.html.erb
    end
  end
  
  
  def advanced
	@keyword = params[:keyword]
	@author = params[:author]
	if params[:range].nil? || params[:range][:"year(1i)"] == ""
		@year_start = nil
		@year_end = nil
	else
		@year_start = Date.civil(params[:range][:"year(1i)"].to_i,1,1)
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
	
	@entries = Entry.find_all_by_status("Approved")
	started = false
	
	if @author != "" && !@author.nil?
		@entries = @entries & Entry.search_author(@author)
		started = true
	end
	if !@keyword.nil? && @keyword != "" 
		@entries = @entries & Entry.search(@keyword)
		started = true
	end
	if !@year_start.nil?
		@entries = @entries & Entry.find(:all, :conditions => ["year >= ? and year <= ?", @year_start, year_end] )
		started = true
	end
	if @exp_type != "n/a" && !@exp_type.nil?
		@entries = @entries & Entry.find_all_by_exp_type(@exp_type)
		started = true
	end
	if  !@env_dim.nil? && @env_dim != "n/a"
		@entries = @entries & Entry.find_all_by_env_dim(@env_dim)
		started = true
	end
	if @env_scale != "n/a" && !@env_scale.nil?
		@entries = @entries & Entry.find_all_by_env_scale(@env_scale)
		started = true
	end
	if @env_density != "n/a" && !@env_density.nil?
		@entries = @entries & Entry.find_all_by_env_density(@env_density)
		started = true
	end
	if @env_realism != "n/a" && !@env_realism.nil?
		@entries = @entries & Entry.find_all_by_env_realism(@env_realism)
		started = true
	end
	if @part_num != "n/a" && !@part_num.nil?
		@entries = @entries & Entry.find_all_by_part_num(@part_num)
		started = true
	end
	if @part_gender != "n/a" && !@part_gender.nil?
		@entries = @entries & Entry.find_all_by_part_gender(@part_gender)
		started = true
	end
	if @specificity != "n/a" && !@specificity.nil?
		@entries = @entries & Entry.find_all_by_specificity(@specificity)
		started = true
	end
	
	if !started || @entries.nil?
		@entries = nil
		@found = "0 results found."
	else
		@entries = @entries.paginate	:page => params[:page], :per_page => 5
		
		if @entries.size == 1
			@found = "1 result found"
		else
			@found = @entries.size.to_s + " results found."
		end
	end
	
	respond_to do |format|
      format.html # advanced.html.erb
    end
  end
  
end