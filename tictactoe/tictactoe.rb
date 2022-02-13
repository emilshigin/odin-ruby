class Play_game
  # Initialize game against computer or another user
  def initialize(against)
    @against = against
    @players = { "player1" => {name:"Player 1", piece:""}, against => {name: "Computer", piece: ""} }
  end

  # Set defualt game board
  def set_defualt_variables
    @game_board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @whos_turn = "player1"
  end
  
  # Draw game board
  def draw_game_board(game_board)
    puts "\t #{@game_board[0]} |  #{@game_board[1]}  |  #{@game_board[2]}"
    puts "\t--------------"
    puts "\t #{@game_board[3]} |  #{@game_board[4]}  |  #{@game_board[5]}"
    puts "\t--------------"
    puts "\t #{@game_board[6]} |  #{@game_board[7]}  |  #{@game_board[8]}\n\n"
  end
  
  # Play each turn
  def play_turn
    # if turn needs keyboard input
    # else turn is automated played by computer
    if @whos_turn == "player1"|| @against == "local"
      # Check if the player pick is valid
      # update the game board
      # switch turnes
      
      print "#{@players[@whos_turn][:name]}, please pick a number: "
      player_pick = (gets.to_i)-1
      while @game_board[player_pick] == @players["player1"][:piece] || @game_board[player_pick] == @players[@against][:piece] || player_pick > 8 || player_pick < 0
        print "You can't pick that number, please pick another number:"
        player_pick = (gets[0].to_i)-1
      end

      @game_board[player_pick] = @players[@whos_turn][:piece]

      @whos_turn == @against ? @whos_turn = "player1" : @whos_turn = @against
    else
      # Computer places piece
      # update the game board
      # switch turnes
      puts "Computer is thinking..."

      computer_pick = rand(0..8)
      while @game_board[computer_pick] == @players["player1"][:piece] || @game_board[computer_pick] == @players[@against][:piece]
        computer_pick = (computer_pick + 1)%9
      end

      @game_board[computer_pick] = @players[@against][:piece]
      
      @whos_turn = "player1"
    end  
  end

  def check_win
    # Check for win return piece of winner
    if @game_board[0] == @game_board[1] && @game_board[1] == @game_board[2]
      return  @game_board[0]
    elsif @game_board[3] == @game_board[4] && @game_board[4] == @game_board[5]
      return  @game_board[3]
    elsif @game_board[6] == @game_board[7] && @game_board[7] == @game_board[8]
      return  @game_board[6]
    elsif @game_board[0] == @game_board[3] && @game_board[3] == @game_board[6]
      return  @game_board[0]
    elsif @game_board[1] == @game_board[4] && @game_board[4] == @game_board[7]
      return  @game_board[1]
    elsif @game_board[2] == @game_board[5] && @game_board[5] == @game_board[8]
      return  @game_board[2]
    elsif @game_board[0] == @game_board[4] && @game_board[4] == @game_board[8]
      return  @game_board[0]
    elsif @game_board[2] == @game_board[4] && @game_board[4] == @game_board[6]
      return  @game_board[2]

    # Draw if every space is taken 
    elsif @game_board.select{|piece| piece == @players["player1"][:piece] || piece == @players[@against][:piece]}.length == 9 ? true : false
      return "draw"
    
    # No Winner yet  
    else
      return false
    end
  end

  def start_game(replay = false,last_game_winner = "player1")
    # Initialize and draw the tic-tac-toe board
    # Computer doesn't choes if first move
    last_game_winner = "player1" if last_game_winner == "computer"
    set_defualt_variables 
    system "clear" or system "cls"
    draw_game_board(@game_board)

    puts "Welcome to Tic Tac Toe"
    
    # Get player Information
    # Unless its a replay
    # Then choose piece 
    unless replay
      print "Who is playing, what should we call you:"
      @input = gets.chomp
      @players["player1"][:name] = @input
      print "#{@players["player1"][:name]}, please pick (O or X):"
      @input = gets[0].to_s.upcase
      @players["player1"][:piece] = @input
    else
      print "#{@players[last_game_winner][:name]}, please pick (O or X):"
      @input = gets[0].to_s.upcase
      @players[last_game_winner][:piece] = @input
    end
    
    # Auto choses the other player's piece
    if last_game_winner == "player1"
      @players["player1"][:piece] == "X" ? @players[@against][:piece] = "O" : @players[@against][:piece] = "X"
      @players[@against][:piece] == "O" ? @whos_turn = "player1" : @whos_turn = @against
    else
      @players[@against][:piece] == "X" ? @players["player1"][:piece] = "O" : @players["player1"][:piece] = "X"
      @players["player1"][:piece] == "O" ? @whos_turn = @against : @whos_turn = "player1"
    end
    
    # Get other player info if unknown
    # Then clear the screen
    # Draw the game board
    if @against=="local" && replay == false
      print "Who is the second player, what your name:"
      @input = gets.chomp
      @players[@against][:name] = @input

      system "clear" or system "cls"
      draw_game_board(@game_board)
      puts "#{@players[@against][:name]}, your piece is #{@players[@against][:piece]}, Lets get started\n"
    end

    # Give Color to the pieces
    @players["player1"][:piece] = "\e[31m#{@players["player1"][:piece]}\e[0m" # Red
    @players[@against][:piece] = "\e[34m#{@players[@against][:piece]}\e[0m" # Blue

    # Game loop
    # Print out who has what piece
    # Play turn
    # Draw updated game board
    # Check for win
    someone_won = false
    while someone_won == false
      puts "#{@players["player1"][:name]} piece: #{@players["player1"][:piece]} || #{@players[@against][:name]} piece: #{@players[@against][:piece]}"
      play_turn
      system "clear" or system "cls"   
      draw_game_board(@game_board)
      someone_won = check_win
    end

    # Game over determine who won
    if someone_won == @players["player1"][:piece]
      replay_winner = "player1"
      puts "#{@players["player1"][:name]} won!"
    elsif someone_won == @players[@against][:piece]
      replay_winner = @against
      puts "#{@players[@against][:name]} won!"
    else
      replay_winner = last_game_winner
      puts "It's a draw!"
    end

    # Ask if to replay
    print "Do you want to play again? 1)yes 2)no:"
    start_game(true,replay_winner) if gets.to_i == 1 
  end
end


menu =  ["Play VS Computer","Play VS Local Friend","Exit"]
skip = false

while true
  # print menu
  unless skip == true
    system "clear" or system "cls"
    puts "############ Lets play Tic-Tac-Toe ############"
    menu.each_with_index {|option,index| puts "#{index+1})  #{option}"}
    puts "##############################################"
    print "Type 1-#{menu.length} to pick option: "
  end
  skip =false

  # Get user input
  # Check what game type user wants or to exit
  case gets.chomp.to_i
  when 1
    play_game = Play_game.new("computer")
    play_game.start_game
  when 2
    play_game = Play_game.new("local")
    play_game.start_game
  when menu.length # exit, last element in menu
    break
  else  
    skip = true
    print "Try again that was not on the list\nWhat would you like to do:"
  end 
end