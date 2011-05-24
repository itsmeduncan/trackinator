class CreateVictims < ActiveRecord::Migration
  def self.up
    create_table :victims do |t|
      t.string :name, :null => false
      t.string :url, :null => false
      t.string :selector, :null => false
      t.integer :interval, :null => false, :default => 1800
      t.timestamp :last_visit, :default => Time.now
      
      t.timestamps
    end
  end

  def self.down
    drop_table :victims
  end
end
