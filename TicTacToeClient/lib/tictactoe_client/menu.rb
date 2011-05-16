module TicTacToeClient
  
  class Menu
    
    attr_reader :active
    
    def initialize(player)
      @player = player
      @active = true
    end
    
    def begin      
      puts "Welcome #{player.name}!"
      puts "Type help for a list of available commands.\n\n"
      while @active
        command = gets.strip
        if respond_to?(command)
          send(command)
        else
          puts "#{command} is not a valid command."
        end
        puts
      end  
      puts 'Bye'    
    end    
  
    def list
      users = @player.list
      puts 'user'.ljust(12) + 'playing'
      users['users'].each do |user|
        puts user['name'].ljust(12) + user['playing'].to_s
      end
    end
    
    def wait
      puts 'Waiting for a player invitation...'
      @player.wait
    end
    
    def quit
      @active = false
    end
  
    def help
      puts <<-HELP
        list - list players registered
        wait - wait for a player invitation
        quit - exit the application
      HELP
    end
    
  end
  
end