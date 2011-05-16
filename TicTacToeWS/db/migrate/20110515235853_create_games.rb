class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :player1
      t.string :player2
      t.string :board, :default => "000000000"

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
