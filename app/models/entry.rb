class Entry < ActiveRecord::Base
  index do
	title			'A'
	authors_string	'A'
	tags_string		'A'
	findings		'A'
	summary			'A'
	
    task_desc		'B'
    interface_desc	'B'
    env_desc		'B'
    systems_tech	'B'
    systems_desc	'B'
    comps_desc		'B'
    variables_desc	'B'
    constants		'B'
    specificity
    issues			'B'
    other			'B'
	
	env_dim			'C'
    env_scale		'C'
    env_density		'C'
    env_realism		'C'
	part_gender		'C'
    part_background	'C'
    part_other		'C'
    exp_type		'C'
  end
  
  index('title') { title }
  index('author') { authors_string }

  belongs_to :user
  
  acts_as_taggable
  acts_as_taggable_on :authors
  acts_as_taggable_on :tasks
  acts_as_taggable_on :systems
  acts_as_taggable_on :comps
  
  acts_as_tsearch :all => {:fields => [:title,:authors_string,:findings]}
  acts_as_tsearch :title => {:fields => [:title]}
  acts_as_tsearch :author => {:fields => [:authors_string]}
  
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
