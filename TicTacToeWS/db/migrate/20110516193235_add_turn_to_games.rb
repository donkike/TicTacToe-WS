class AddTurnToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :turn, :integer, :default => 0
  end

  def self.down
    remove_column :games, :turn
  end
end
