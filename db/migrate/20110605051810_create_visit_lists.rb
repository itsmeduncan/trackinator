class CreateVisitLists < ActiveRecord::Migration
  def self.up
    create_table :visit_lists do |t|
      t.references :victim
      t.text :list, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :visit_lists
  end
end
