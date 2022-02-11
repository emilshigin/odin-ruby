class Play_game
  def initialize(against)
    @@against = against
  end

  def set_defualt_variables
    @@game_board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @@player_piece = ""
    @@oponint_piece = ""
    @@whos_turn = "player"
  end
  
  def draw_game_board(game_board)
    puts "\t #{@@game_board[0]} |  #{@@game_board[1]}  |  #{@@game_board[2]}"
    puts "\t--------------"
    puts "\t #{@@game_board[3]} |  #{@@game_board[4]}  |  #{@@game_board[5]}"
    puts "\t--------------"
    puts "\t #{@@game_board[6]} |  #{@@game_board[7]}  |  #{@@game_board[8]}\n\n"
  end
  
  def play_turn
    if @@whos_turn == "player"
      print "Player, please pick a number: "
      player_pick = (gets.to_i)-1
      while @@game_board[player_pick] == @@player_piece || @@game_board[player_pick] == @@oponint_piece || player_pick > 8 || player_pick < 0
        print "You can't pick that number, please pick another number:"
        player_pick = (gets[0].to_i)-1
      end
      @@game_board[player_pick] = @@player_piece
      @@whos_turn ="oponint"
    else
      puts "Ai is thinking..."
      # Computer pick
      computer_pick = rand(0..8)
      while @@game_board[computer_pick] == @@player_piece || @@game_board[computer_pick] == @@oponint_piece
        computer_pick = (computer_pick + 1)%9
      end
      @@game_board[computer_pick] = @@oponint_piece
      @@whos_turn = "player"
      sleep(1)
    end  
  end

  def check_win
    return "draw" if @@game_board.select{|piece| piece == @@player_piece || piece == @@oponint_piece}.length == 9 ? true : false
    # Check for win return piece of winner
    if @@game_board[0] == @@game_board[1] && @@game_board[1] == @@game_board[2]
      return  @@game_board[0]
    elsif @@game_board[3] == @@game_board[4] && @@game_board[4] == @@game_board[5]
      return  @@game_board[3]
    elsif @@game_board[6] == @@game_board[7] && @@game_board[7] == @@game_board[8]
      return  @@game_board[6]
    elsif @@game_board[0] == @@game_board[3] && @@game_board[3] == @@game_board[6]
      return  @@game_board[0]
    elsif @@game_board[1] == @@game_board[4] && @@game_board[4] == @@game_board[7]
      return  @@game_board[1]
    elsif @@game_board[2] == @@game_board[5] && @@game_board[5] == @@game_board[8]
      return  @@game_board[2]
    elsif @@game_board[0] == @@game_board[4] && @@game_board[4] == @@game_board[8]
      return  @@game_board[0]
    elsif @@game_board[2] == @@game_board[4] && @@game_board[4] == @@game_board[6]
      return  @@game_board[2]
    else
      return false
    end
  end

  def start_game
    # Inisialize game board
    set_defualt_variables 
    system "clear" or system "cls"
    draw_game_board(@@game_board)
    puts "Welcome to Tic Tac Toe"
    print "Player, please pick O or X:"
    @@player_piece = gets[0].to_s.upcase
    
    # Opponint piece
    @@player_piece == "X" ? @@oponint_piece = "O" : @@oponint_piece = "X"
    @@oponint_piece == "O" ? @@whos_turn = "player" : @@whos_turn = "oponint"
    
    # Game loop
    someone_won = false
    while someone_won == false
      puts "player piece: #{@@player_piece} oponint piece: #{@@oponint_piece}"
      play_turn
      system "clear" or system "cls"   
      draw_game_board(@@game_board)
      someone_won = check_win
    end

    # Game over
    if someone_won == @@player_piece
      puts "Player won!"
    elsif someone_won == @@oponint_piece
      puts "Opponint won!"
    else
      puts "It's a draw!"
    end
    print "do you want to play again 1)yes 2)no:"
    start_game if gets.to_i == 1 
  end
end

menu =  ["Play VS Computer","Play VS Local Friend","Exit"]
skip = false

while true
  # print menu
  unless skip == true
    system "clear" || system "cls"
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