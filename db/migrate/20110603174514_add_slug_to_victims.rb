class AddSlugToVictims < ActiveRecord::Migration
  def self.up
    add_column :victims, :slug, :string

    Victim.all.each do |victim|
      victim.update_attribute(:slug, victim.to_param)
    end

    add_index :victims, :slug, :unique => true
  end

  def self.down
    remove_column :victims, :slug, :string, :null => false
  end
end
