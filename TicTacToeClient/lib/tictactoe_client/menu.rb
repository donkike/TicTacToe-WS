module TicTacToeClient
  
  class Menu
    
    attr_reader :active
    
    def initialize(player)
      @player = player
      @active = true
    end
    
    def begin      
      puts "Welcome #{@player.name}!"
      puts "Type help for a list of available commands.\n\n"
      while @active
        command, param = gets.strip.split(' ')
        if respond_to?(command)
          send(command, param)
        else
          puts "#{command} is not a valid command."
        end
        puts
      end  
      puts 'Bye'    
    end   
    
    def play(player = nil)
      if player
        begin
          @player.register
          @player.begin(player)
        rescue Exception => e
          puts "Error beginning game: #{e.message}"
        end
      else
        puts "No player selected"
      end
    end 
  
    def list(*args)
      users = @player.list
      puts 'user'.ljust(12) + 'playing'
      users['users'].each do |user|
        puts user['name'].ljust(12) + user['playing'].to_s
      end
    end
    
    def wait(*args)
      puts 'Waiting for a player invitation...'
      @player.wait
    end
    
    def quit(*args)
      @player.unregister
      @active = false
    end
  
    def help(*args)
      puts <<-HELP
        play [player] - request game to [player]
        list          - list players registered
        wait          - wait for a player invitation
        quit          - exit the application
      HELP
    end
    
  end
  
end