class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  has_mobile_fu
 
  before_filter :tag_cloud
  before_filter :get_keyword
  before_filter :get_tags
  
  def tag_cloud
	@master_tags = (Entry.tag_counts_on(:authors) + Entry.tag_counts_on(:comps) + Entry.tag_counts_on(:systems) + Entry.tag_counts_on(:tasks)).sort_by {rand}
  end
  
  def get_keyword
	@keyword = params[:keyword]
  end
	
  def get_tags
	@master_components = Component.find(:all)
	@master_systems = System.find(:all)
	@master_tasks = Task.find(:all)
  end
  
end
