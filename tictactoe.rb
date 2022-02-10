class Play_game
  @@game_board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  @@player_piece = ""
  @@oponint_piece = ""
  @@whos_turn = "player"
  
  def draw_game_board(game_board)
    puts "\t #{@@game_board[0]} |  #{@@game_board[1]}  |  #{@@game_board[2]}"
    puts "\t--------------"
    puts "\t #{@@game_board[3]} |  #{@@game_board[4]}  |  #{@@game_board[5]}"
    puts "\t--------------"
    puts "\t #{@@game_board[6]} |  #{@@game_board[7]}  |  #{@@game_board[8]}\n\n"
  end
  
  def play_turn(@@whos_turn)
    if @@whos_turn == "player"
      print "Player, please pick a number: "
      player_pick = gets[0].to_i % 9

      @@whos_turn == "oponint"
    else
      @@whos_turn == "player"
    end
  end

  def start_game 
    # Inisialize game board
    draw_game_board(@@game_board)
    puts "Welcome to Tic Tac Toe"
    print "Player, please pick O or X:"
    @@player_piece = gets[0].upcase
    
    # Opponint piece
    @@player_piece == "X" ? @@oponint_piece = "O" : @@oponint_piece = "X"
    @@oponint_piece = "O" ? whos_turn = "player" : whos_turn = "oponint"
    
    someone_won = true
    while someone_won == false
      p "piece: #{@@player_piece} oponint: #{@@oponint_piece}"
      play_turn(@@whos_turn)   
      draw_game_board(@@game_board)
    end

    sleep(1)
  end
end

menu =  ["Play Tic-Tac-Toe","Settings","Exit"]
skip = false

while true
  unless skip == true
    system "clear"
    puts "################ Your Options ################"
    menu.each_with_index {|option,index| puts "#{index+1})  #{option}"}
    puts "##############################################"
    print "Type 1-#{menu.length} to pick option: "

  end
    skip =false

  case gets.chomp.to_i
  when 1
    system "clear"
    play_game = Play_game.new
    play_game.start_game
  when 2
    puts "wha you need"
  when menu.length #exit last option in the menu array
    break
  else  
    skip = true
    print "Try again that was not on the list\nWhat would you like to do:"
  end 
end