class Game < ActiveRecord::Base
  
  attr_accessible :player1, :player2, :turn, :board
  
  after_create :update_players

  def play(move)
    if move[:turn].to_i == turn      
       self.board[move[:move].to_i] = (move[:turn].to_i + 1).to_s
       self.turn = (self.turn + 1) % 2
       true
    else
       false
    end
  end
  
  private  
  def update_players
    user = User.find_by_name(player2)
    user.playing = true
    user.save
  end
  
end
