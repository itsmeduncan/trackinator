class AddUserIdToVictims < ActiveRecord::Migration
  def self.up
    add_column :victims, :user_id, :integer
    add_index :victims, :user_id
  end

  def self.down
    remove_column :victims, :user_id
  end
end
