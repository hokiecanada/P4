class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  has_mobile_fu
 
  before_filter :tag_cloud
  before_filter :get_keyword
  before_filter :get_tags
  
  def tag_cloud
	@tags = (Entry.tag_counts_on(:authors) + Entry.tag_counts_on(:comps) + Entry.tag_counts_on(:systems) + Entry.tag_counts_on(:tasks)).sort_by {rand}
  end
  
  def get_keyword
	@keyword = params[:keyword]
  end
	
  def get_tags
	@components = Component.find(:all)
	@systems = System.find(:all)
	@tasks = Task.find(:all)
  end
  
end
