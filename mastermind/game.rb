require_relative 'display.rb'
require_relative 'computer_guesses.rb'
require_relative 'player_guesses.rb'

include Display
include PlayerGuesses
include ComputerGuesses

loop do
  system 'clear' or 'cls'
  puts start_menu
  input = user_input
  system 'clear' or 'cls'
  case input
  when "1", "player"
    print "player guess combo"
    gets
    
  when "2", "computer"
    computer_guesses
    when "3", "rules"
      puts rules_message
      print "Press any key to continue..."
      gets

    when "4" , "exit"
      break
    end
end