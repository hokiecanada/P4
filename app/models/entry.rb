class Entry < ActiveRecord::Base
  acts_as_tsearch 	:fields => [:title,:authors_string]

  belongs_to :user
  
  acts_as_taggable
  acts_as_taggable_on :authors
  acts_as_taggable_on :tasks
  acts_as_taggable_on :systems
  acts_as_taggable_on :comps
  


  
  validates :title, 				:presence => true
  #validates :paper_url, 			:presence => true
  #validates :authors, 				:presence => true
  #validates :year,					:presence => true
  #validates :citation, 				:presence => true
  #validates :task, 					:presence => true
  #validates :env_dim, 				:presence => true
  #validates :env_scale, 			:presence => true
  #validates :env_density, 			:presence => true
  #validates :env_realism, 			:presence => true
  #validates :part_num, 				:presence => true
  #validates :part_gender, 			:presence => true
  #validates :exp_type, 				:presence => true
  #validates :findings,				:presence => true,
			#:length => { :minimum => 100 }
  #validates :specificity, 			:presence => true
  #validates :summary, 				:presence => true,
			#:length => { :minimum => 20, :maxiumum => 100 }
  

  has_many :comments, :dependent => :destroy
end
