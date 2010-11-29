class Entry < ActiveRecord::Base
  index do
	title
	summary
  end
	
  #searchable do
	#text :title, :default_boost => 2
	#text :summary
	#text :author_list
  #end

  belongs_to :user
  
  acts_as_taggable
  acts_as_taggable_on :authors
  acts_as_taggable_on :tasks
  #acts_as_taggable_on :part_num
  acts_as_taggable_on :systems
  acts_as_taggable_on :comps
  
  #validates :author, 		:presence => true
  #validates :title, 		:presence => true
  #validates :summary, 		:presence => true,
	#						:length => { :minimum => 20, :maxiumum => 200 }
  #validates :citation, 		:presence => true
  #validates :participants, 	:presence => true
  #validates :size, 			:presence => true
  #validates :realism, 		:presence => true
  
  has_many :comments, :dependent => :destroy
end
