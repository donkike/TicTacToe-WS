require 'tictactoe_client/server'

module TicTacToeClient
  class Player
    
    attr_reader :name, :server
    
    def initialize(name, server)
      @name = name
      @server = server
      @playing = false
      @id = nil
      @game = nil
    end    
    
    def register
      user = Server.post(server + '/users', {:body => {:user => {:name => name}}}).parsed_response
      @id = user['user']['id']
    end
    
    def begin(with_player)
      @game = Server.post(server + '/games', {:body => {:game => {:player1 => @name, :player2 => with_player}}}).parsed_response
    end
    
    def list
      Server.get(server + '/users.xml').parsed_response
    end
    
    def wait
      while not @playing
        sleep(5)
        @playing = Server.get(server + '/users/' + @id.to_s + '.xml').parsed_response['user']['playing']
      end
    end
    
  end
end