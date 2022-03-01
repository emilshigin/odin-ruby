module PlayerGuesses
  def player_guesses
    # Compter picks
    secret_combo = 4.times.map { rand(1..7)}.join
  
    # Player guesses
    game_resualt = player_guesses_combo(secret_combo)
    
    # Win screen
    win_screen(game_resualt)
  
    #  Replay 
    puts "Do you want to play again? (y/n): "
    input = user_input
    case input.downcase
    when "y"
      player_guesses
    when "n"
      puts "Thanks for playing!"
    end
  end

  def player_guesses_combo(secret_combo)
    resualt = "lose"
    12.times do |i|
      # guess number
      puts "Enter your guess: "
      code = pick_check_color

      # print code and hints
      print_color(code.split(""))
      position = hint_positions(secret_combo, code)
      print_hint(position[0], position[1])
      puts # new line

      #change resualt 
      if secret_combo == code 
        resualt = "win"
        break
      end
    end
    
    puts "The correct code was:"
    print_color(secret_combo.split(""))

    resualt
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