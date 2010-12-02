class AddStringsToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :tags_string, :string
  end

  def self.down
    remove_column :entries, :tags_string
  end
end
