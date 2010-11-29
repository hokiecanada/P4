class CreateFavorites < ActiveRecord::Migration
  def self.up
    create_table :favorites do |t|
      t.integer :entry_id
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :favorites
  end
end
