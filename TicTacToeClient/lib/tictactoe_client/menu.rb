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

    def paint
      board = @player.game['board']
      (0..3).each do |i| 
         puts [board[i*3], board[i*3+1], board[i*3+2]].join(" ")
      end
    end   
    
    def play(player = nil)
      if player
        begin
          @player.begin(player)
          paint
        rescue Exception => e
          puts "Error beginning game: #{e.message}"
        end
      else
        puts "No player selected"
      end      
      playing
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
      puts "Playing with #{@player.game['player1']}"
      paint
      playing
    end
    
    def move(move)
       @player.move(move)
       paint
    end

    def quit(*args)
      @active = false
    end

    def playing
      while @player.playing
        if @player.turn == @player.game['turn'].to_i
	        puts 'Make your move'
          paint
	        move = gets.strip
	        @player.move(move.to_i)
        else
	        @player.refresh_game
	        sleep(5)
        end
      end
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
