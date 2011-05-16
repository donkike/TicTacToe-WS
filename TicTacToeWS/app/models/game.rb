class Game < ActiveRecord::Base
  
  validate :not_same_player
  
  after_create :update_players

  def play(move)
    if move[:turn].to_i == self.turn
       self.board[move[:move].to_i] = (move[:turn].to_i + 1).to_s
       self.turn = (self.turn + 1) % 2
    else
       false
    end
  end
  
  private
  def not_same_player
    player1 != player2
  end
  
  def update_players
    user = User.find_by_name(player2)
    user.playing = true
    user.save
  end
  
end
