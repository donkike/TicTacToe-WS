class AddPlayingToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :playing, :boolean, :default => false
  end

  def self.down
    remove_column :users, :playing
  end
end
