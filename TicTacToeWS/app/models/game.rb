class Game < ActiveRecord::Base
  
  validate :not_same_player
  validates :player1, :player2, :player_not_playing => true
  
  after_create :update_players
  
  private
  def not_same_player
    player1 != player2
  end
  
  def update_players
    user1 = User.find_by_name(player1)
    user1.playing = true
    user1.save
    user2 = User.find_by_name(player2)
    user2.playing = true
    user2.save
  end
  
end