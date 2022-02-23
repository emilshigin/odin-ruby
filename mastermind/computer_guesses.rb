module ComputerGuesses  
  def initialize
    @code_contains =  {
      
    }
    @@guess_limit = 12
    @@guess_count = 0
  end

  def computer_guesses
    initialize
    #  player pickes combo 
    secret_combo = player_pick_color
    
    #  Computer guesses Cobo
    puts "\nLets see if the computer can break it in 9 guesses...\n"
    game_resualt = computer_guesses_combo(secret_combo)
    
    #  Win screen
    win_screen(game_resualt)
    
    #  Replay 
    puts "Do you want to play again? (y/n): "
    input = user_input
    case input.downcase
    when "y"
      computer_guesses
    when "n"
      puts "Thanks for playing!"
    end
  end
  

  
  def computer_guesses_combo(secret_combo, code = "1111", guess_count = 1)
    
    # display computer guess
    puts "\nComputer Guess: #{code}"
    print_color(code.split(""))
    print " "
    hint = hint_positions(secret_combo, code)
    print_hint(hint[0], hint[1])

    #win logic
    return "lose" if code == secret_combo
    return "win" if guess_count == @@guess_limit

    #logic for next guess
    color_in_combo = 4-(hint[0]+hint[1])
    
    computer_guesses_combo(secret_combo, code, guess_count += 1)
    
  end 

  def hint_positions(secret_combo, code)
    hint_position = [0,0]
    secret_combo.split("").each_with_index do |color, index|
      hint_position[0] +=1 if color == code[index] 
      hint_position[1] +=1 if code.include?(color) && color != code[index]
    end
    return hint_position
  end

end