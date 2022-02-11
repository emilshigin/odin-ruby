class Play_game
  # Determine who's user is playing against
  def initialize(against)
    @against = against
    @players = { "player1" => {name:"Player 1", piece:""}, against => {name: "Computer", piece: ""} }
  end

  # Set defualt variables
  def set_defualt_variables
    @game_board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @whos_turn = "player1"
  end
  
  def draw_game_board(game_board)
    puts "\t #{@game_board[0]} |  #{@game_board[1]}  |  #{@game_board[2]}"
    puts "\t--------------"
    puts "\t #{@game_board[3]} |  #{@game_board[4]}  |  #{@game_board[5]}"
    puts "\t--------------"
    puts "\t #{@game_board[6]} |  #{@game_board[7]}  |  #{@game_board[8]}\n\n"
  end
  
  def play_turn
    if @whos_turn == "player1"|| @against == "local"
      # Check if the player pick is valid
      print "#{@players[@whos_turn][:name]}, please pick a number: "
      player_pick = (gets.to_i)-1
      while @game_board[player_pick] == @players["player1"][:piece] || @game_board[player_pick] == @players[@against][:piece] || player_pick > 8 || player_pick < 0
        print "You can't pick that number, please pick another number:"
        player_pick = (gets[0].to_i)-1
      end

      # update the game board
      @game_board[player_pick] = @players[@whos_turn][:piece]

      # switch turnes
      @whos_turn == @against ? @whos_turn = "player1" : @whos_turn = @against
    else
      puts "Computer is thinking..."

      # Computer places piece
      computer_pick = rand(0..8)
      while @game_board[computer_pick] == @players["player1"][:piece] || @game_board[computer_pick] == @players[@against][:piece]
        computer_pick = (computer_pick + 1)%9
      end

      # update the game board
      @game_board[computer_pick] = @players[@against][:piece]
      
      # switch turnes
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

    #Check if every space is taken
    elsif @game_board.select{|piece| piece == @players["player1"][:piece] || piece == @players[@against][:piece]}.length == 9 ? true : false
      return "draw"
    
    # No Winner yet  
    else
      return false
    end
  end

  def start_game(replay = false,first_choice = "player1")
    # Initialize and draw the tic-tac-toe board
    first_choice = "player1" if first_choice == "computer"
    set_defualt_variables 
    system "clear" or system "cls"
    draw_game_board(@game_board)

    puts "Welcome to Tic Tac Toe"
    
    # Player pick name & piece
    unless replay
      print "Who is playing, what should we call you:"
      @input = gets.chomp
      @players["player1"][:name] = @input
      print "#{@players["player1"][:name]}, please pick (O or X):"
      @input = gets[0].to_s.upcase
      @players["player1"][:piece] = @input
    else
      print "#{@players[first_choice][:name]}, please pick (O or X):"
      @input = gets[0].to_s.upcase
      @players[first_choice][:piece] = @input
    end
    
    # Auto choses the other person's piece
    if first_choice == "player1"
      @players["player1"][:piece] == "X" ? @players[@against][:piece] = "O" : @players[@against][:piece] = "X"
      @players[@against][:piece] == "O" ? @whos_turn = "player1" : @whos_turn = @against
    else
      @players[@against][:piece] == "X" ? @players["player1"][:piece] = "O" : @players["player1"][:piece] = "X"
      @players["player1"][:piece] == "O" ? @whos_turn = @against : @whos_turn = "player1"
    end
    
    if @against=="local" && replay == false
      print "Who is the second player, what your name:"
      @input = gets.chomp
      @players[@against][:name] = @input

      # Clear the screen and draw the game board for asstetics
      system "clear" or system "cls"
      draw_game_board(@game_board)

      puts "#{@players[@against][:name]}, your piece is #{@players[@against][:piece]}, Lets get started"
    end

    # Game loop
    someone_won = false
    while someone_won == false
      puts "#{@players["player1"][:name]} piece: #{@players["player1"][:piece]} || #{@players[@against][:name]} piece: #{@players[@against][:piece]}"
      play_turn
      system "clear" or system "cls"   
      draw_game_board(@game_board)
      someone_won = check_win
    end

    # Game over, Who won?
    if someone_won == @players["player1"][:piece]
      replay_winner = "player1"
      puts "#{@players["player1"][:name]} won!"
    elsif someone_won == @players[@against][:piece]
      replay_winner = @against
      puts "#{@players[@against][:name]} won!"
    else
      replay_winner = first_choice
      puts "It's a draw!"
    end

    #do you want to play again?
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

  case gets.chomp.to_i
  # Play game with
  when 1
    play_game = Play_game.new("computer")
    play_game.start_game
  when 2
    play_game = Play_game.new("local")
    play_game.start_game
    # Exit game always last entry in menu array
  when menu.length
    break
  
  else  
    skip = true
    print "Try again that was not on the list\nWhat would you like to do:"
  end 
end