module TicTacToeClient
  
  class Menu
    
    attr_reader :active
    
    def initialize(player)
      @player = player
      @active = true
      @repr = %w[X O]
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
    
    def show(i)
      @player.game['board'][i] == '0' ? (i + 1) : @repr[@player.game['board'][i].to_i - 1]
    end

    def paint
      puts <<-BOARD
           |     |     
        #{show(0)}  |  #{show(1)}  |  #{show(2)} 
           |     |  
      -----+-----+-----
           |     |
        #{show(3)}  |  #{show(4)}  |  #{show(5)}
           |     |   
      -----+-----+-----
        #{show(6)}  |  #{show(7)}  |  #{show(8)}
           |     |   
      BOARD
    end  

    def has_finished(board)
      if (board[0] == board[1] && board[1] == board[2] && board[0] == '1')
	      return 1
      end
      if (board[3] == board[4] && board[4] == board[5] && board[3] == '1')
        return 1
      end
      if (board[6] == board[7] && board[7] == board[7] && board[6] == '1')
	      return 1
      end
      if (board[0] == board[3] && board[3] == board[6] && board[0] == '1')
	      return 1
      end
      if (board[1] == board[4] && board[4] == board[7] && board[1] == '1')
	      return 1
      end
      if (board[2] == board[5] && board[5] == board[8] && board[2] == '1')
	      return 1
      end
      if (board[0] == board[4] && board[4] == board[8] && board[0] == '1')
	      return 1
      end
      if (board[2] == board[4] && board[4] == board[6] && board[2] == '1')
	      return 1
      end
      if (board[0] == board[1] && board[1] == board[2] && board[0] == '2')
          return 2
      end
      if (board[3] == board[4] && board[4] == board[5] && board[3] == '2')
	        return 2
      end
      if (board[6] == board[7] && board[7] == board[7] && board[6] == '2')
	        return 2
      end
      if (board[0] == board[3] && board[3] == board[6] && board[0] == '2')
	        return 2
      end
      if (board[1] == board[4] && board[4] == board[7] && board[1] == '2')
	        return 2
      end
      if (board[2] == board[5] && board[5] == board[8] && board[2] == '2')
	        return 2
      end
      if (board[0] == board[4] && board[4] == board[8] && board[0] == '2')
	        return 2
      end
      if (board[2] == board[4] && board[4] == board[6] && board[2] == '2')
	        return 2
      end
      unless board.include?('0')
          return -1
      end
      0
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
	        @player.move(move.to_i - 1)
	        paint
	        puts "Waiting for next player..."
        else
	        @player.refresh_game
	        sleep(2)
        end
        status = has_finished(@player.game['board'])
	      if status != 0
	        @player.refresh_game
	        paint
	        if status == @player.turn + 1
	          puts "You win!"
	        elsif status == -1
	          puts "It's a tie"
	        else
	          puts "You lose..."
	        end
	        @player.end_game if @player.turn == @player.game['turn'].to_i 
		      @player.playing = false
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
