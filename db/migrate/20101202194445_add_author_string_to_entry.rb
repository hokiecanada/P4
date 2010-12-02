class AddAuthorStringToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :authors_string, :string
  end

  def self.down
    remove_column :entries, :authors_string
  end
end
