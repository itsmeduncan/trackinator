class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.float :value
      t.integer :status
      t.integer :victim_id
      t.timestamps
    end
  end

  def self.down
    drop_table :visits
  end
end
