class Entry < ActiveRecord::Base
  index do
	title
	authors
    task
    task_desc
    interface_desc
    env_dim
    env_scale
    env_density
    env_realism
    env_desc
    part_gender
    part_background
    part_other
    exp_type
	systems
    systems_tech
    systems_desc
    comps
    comps_desc
    variables_desc
    constants
    findings
    specificity
    issues
    summary
    other
  end
  
  index('author') { authors }

  belongs_to :user
  
  acts_as_taggable
  #acts_as_taggable_on :authors
  acts_as_taggable_on :tasks
  #acts_as_taggable_on :part_num
  acts_as_taggable_on :systems
  acts_as_taggable_on :comps
  
  
  validates :title, 				:presence => true
  validates :paper_url, 			:presence => true
  validates :authors, 				:presence => true
  validates :year,					:presence => true
  validates :citation, 				:presence => true
  #validates :task, 					:presence => true
  #validates :task_desc, 			:presence => true
  #validates :interface_desc, 		:presence => true
  validates :env_dim, 				:presence => true
  validates :env_scale, 			:presence => true
  validates :env_density, 			:presence => true
  validates :env_realism, 			:presence => true
  #validates :env_desc, 			:presence => true
  validates :part_num, 				:presence => true
  validates :part_gender, 			:presence => true
  #validates :part_age, 				:presence => true
  #validates :part_background, 		:presence => true
  #validates :part_other, 			:presence => true
  validates :exp_type, 				:presence => true
  #validates :systems, 				:presence => true
  #validates :systems_tech, 			:presence => true
  #validates :systems_desc,			:presence => true
  #validates :comps,					:presence => true
  #validates :comps_desc,			:presence => true
  validates :findings,				:presence => true,
			:length => { :minimum => 100 }
  validates :specificity, 			:presence => true
  validates :summary, 				:presence => true,
			:length => { :minimum => 20, :maxiumum => 100 }
  

  has_many :comments, :dependent => :destroy
end
