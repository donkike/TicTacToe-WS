class Game < ActiveRecord::Base
  
  validate :not_same_player
  validate :players_not_playing
  
  after_create :update_players
  
  private
  def not_same_player
    player1 != player2
  end

  def players_not_playing
    not User.find_by_name(player1).playing and not User.find_by_name(player2).playing
  end
  
  def update_players
    user1 = User.find_by_name(player1).playing = true
    user1.save
    user2 = User.find_by_name(player2).playing = true
    user2.save
  end
  
end
