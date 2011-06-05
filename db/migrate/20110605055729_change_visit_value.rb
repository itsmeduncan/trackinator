class ChangeVisitValue < ActiveRecord::Migration
  def self.up
    change_column :visits, :value, :text
  end

  def self.down
    change_column :visits, :value, :float
  end
end
