class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :title
      t.string :paper_url
      t.string :authors
      t.date :year
      t.string :citation
      t.string :task
      t.text :task_desc
      t.text :interface_desc
      t.string :env_dim
      t.string :env_scale
      t.string :env_density
      t.string :env_realism
      t.text :env_desc
      t.string :part_num
      t.string :part_gender
      t.string :part_age
      t.text :part_background
      t.text :part_other
      t.string :exp_type
      t.string :systems
      t.string :systems_tech
      t.text :systems_desc
      t.string :comps
      t.text :comps_desc
      t.text :variables_desc
      t.text :constants
      t.text :findings
      t.string :specificity
      t.text :issues
      t.text :summary
	  t.text :other
      t.integer :viewed
	  t.string :status
	  t.string :tags_string
	  t.string :authors_string
      t.references :user
	  
      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
