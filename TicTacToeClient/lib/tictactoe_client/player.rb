require 'tictactoe_client/game'

module TicTacToeClient
  class Player
    
    attr_reader :name, :server
    
    def initialize(name, server)
      @name = name
      @server = server
      @playing = false
    end    
    
    def register
      user = Game.post(server + '/users', {:body => {:user => {:name => name}}}).parsed_response
      @id = user['user']['id']
    end
    
    def begin
      
    end
    
    def wait
      while not @playing
        sleep(5)
        @playing = Game.get(server + '/users/' + @id.to_s + '.xml').parsed_response['user']['playing']
      end
    end
    
  end
end