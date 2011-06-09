class ChangeDefaultVisitInterval < ActiveRecord::Migration
  def self.up
    change_column :victims, :interval, :integer, :default => 86400
  end

  def self.down
    change_column :victims, :interval, :integer, :default => 3600
  end
end
