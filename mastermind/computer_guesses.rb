module ComputerGuesses  
  def initialize
    @@code_contains =  {
      "1" => {number: "0", possible_position: [0,1,2,3]},
      "2" => {number: "0", possible_position: [0,1,2,3]},
      "3" => {number: "0", possible_position: [0,1,2,3]},
      "4" => {number: "0", possible_position: [0,1,2,3]}
    }
    @@guess_limit = 12
    @@guess_count = 1
    @@guess_history = [0,0] 
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
    print  "\n\e[41m#{@@code_contains}\e[0m\n\n"
    
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
  

  
  def computer_guesses_combo(secret_combo, code = "1111")
    
    # display computer guess
    puts "\nComputer Guess: #{code}"
    print_color(code.split(""))
    print " "
    hint = hint_positions(secret_combo, code)
    print_hint(hint[0], hint[1])
    
    # add number to code contains we know
    total_guess_history =  @@guess_history[0] + @@guess_history[1]
    number_new_known_numbers = (hint[0] + hint[1]) - total_guess_history

    number_new_known_numbers.times do |i|
      index = (total_guess_history+i+1).to_s
      @@code_contains[index][:number] = @@guess_count
    end

    # update possable position
    # past exact position is more the current exact position 
    # means the past added number can not be in that position  
    # if @@guess_history[0] > guess_history[0]

    
    # win logic
    return "lose" if code == secret_combo
    return "win" if @@guess_count == @@guess_limit
    
    #logic for next guess
    color_in_combo = 4-(hint[0]+hint[1])
    
    # fill in the next guess with next number
    if color_in_combo > 0
      color_in_combo.times do |i|
        code[3-i] = ((@@guess_count+1)%8).to_s
      end
    else
      code = code.split("").shuffle.join("")
    end
    
    # update counters
    @@guess_history[0] += hint[0]
    @@guess_history[1] += hint[1]
    @@guess_count += 1
    computer_guesses_combo(secret_combo, code)
    
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