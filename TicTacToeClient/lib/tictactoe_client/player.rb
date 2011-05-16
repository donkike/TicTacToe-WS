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
        @game = response
      end
    end
    
    def list
      Server.get(server + '/users.xml').parsed_response
    end
    
    def wait
      begin
        register
        while not @playing
          sleep(5)
          @playing = Server.get(server + '/users/' + @id.to_s + '.xml').parsed_response['user']['playing']
        end
      rescue Exception => e
        puts "Error registering player: #{e.message}"
      end      
    end
    
  end
end