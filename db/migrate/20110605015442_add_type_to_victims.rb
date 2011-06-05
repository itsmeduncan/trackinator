class AddTypeToVictims < ActiveRecord::Migration
  def self.up
    add_column :victims, :type, :string
    Victim.update_all :type => 'NumericVictim'
  end

  def self.down
    remove_column :victims, :type
  end
end
