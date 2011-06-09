class RemoveSlugFromVictim < ActiveRecord::Migration
  def self.up
    remove_column :victims, :slug
  end

  def self.down
    add_column :victims, :slug, :string
    add_index :victims, :slug
  end
end
