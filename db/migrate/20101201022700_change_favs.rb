class ChangeFavs < ActiveRecord::Migration
  def self.up
	drop_table :favorites
  end

  def self.down
  	create_table :favorites do |t|
      t.integer :entry_id
      t.references :user

      t.timestamps
    end
  end
end
