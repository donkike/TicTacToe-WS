class Game < ActiveRecord::Base
  
  after_create :update_players

  def play(move)
    if move[:turn].to_i == turn      
       board[move[:move].to_i] = (move[:turn].to_i + 1).to_s
       turn = (self.turn + 1) % 2
       update_attributes({:board => board, :turn => turn})
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
