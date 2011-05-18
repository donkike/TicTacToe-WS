require 'tictactoe_client/server'

module TicTacToeClient
  class Player
    
    attr_reader :name, :server, :game, :turn
    attr_accessor :playing
    
    def initialize(name, server)
      @name = name
      @server = server
      @playing = false
      @id = nil
      @game = nil
    end    
    
    def register
      response = Server.post(server + '/users', {:body => {:user => {:name => name}}}).parsed_response
      if response['errors']
        raise Exception, response['errors']['error']
      else
        @id = response['user']['id']
      end
    end
    
    def unregister
      Server.delete(server + '/users/' + @id.to_s)
    end
    
    def begin(with_player)
      response = Server.post(server + '/games', {:body => {:game => {:player1 => @name, :player2 => with_player}}}).parsed_response
      if response['errors']
        raise Exception, response['errors']['error']
      else
        @game = response['game']
	      @turn = 0
        @playing = true
      end
    end
    
    def list
      Server.get(server + '/users.xml').parsed_response
    end
    
    def end_game
      Server.delete(server + '/games/' + @game['id'].to_s)
    end
    
    def wait
      begin
        register
        while not @playing
          sleep(5)
          @playing = Server.get(server + '/users/' + @id.to_s + '.xml').parsed_response['user']['playing']
        end
	      unregister
	      @game = Server.get(server + '/games/get_by_name/' + @name).parsed_response['game']
	      @turn = 1
      rescue Exception => e
        puts "Error registering player: #{e.message}"
      end      
    end
    
    def move(move)
      @game['board'][move] = (@turn + 1).to_s
      @game = Server.put(server + '/games/' + @game['id'].to_s, {:body => {:game => {:board => @game['board'], :turn => (@turn + 1) % 2}}}).parsed_response['game']
    end
    
    def refresh_game
      @game = Server.get(server + '/games/' + @game['id'].to_s + '.xml').parsed_response['game']
    end
  end
end
