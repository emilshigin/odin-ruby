@game_objective = "Objective of the game is to guess a 4 color combination in the correct order"

@hint_rule = "Each guess gets a hint: 
A blank circle means you found a correct color but not in the correct place
A filled cicle means you have the correct color in the correcct place"

@color_maping = {
  1 => "\e[41;30m  1  \e[0m",
  2 => "\e[42;30m  2  \e[0m",
  3 => "\e[43;30m  3  \e[0m",
  4 => "\e[44;30m  4  \e[0m",
  5 => "\e[45;30m  5  \e[0m",
  6 => "\e[46;30m  6  \e[0m",
  7 => "\e[47;30m  7  \e[0m",
}
system "clear" or system "cls"
@color_maping.each {|color|  print color[1]}
puts "\nPick your 4 colors each number represents a color"

while @secret_combo = gets.chomp
  break if @secret_combo.match(/^[1-7]{1,4}$/) != nil

  puts "\e[31mOne or more of the choosen colors do not exist.\e[0m" if @secret_combo.match(/^[1-7]{1,}$/) == nil 
  puts "\e[31mRemember the combo length needs to be 4 colors.\e[0m" if  @secret_combo.match(/^[0-9]{1,4}$/) == nil

  print "Please enter a correct combo:"
end
  


p @secret_combo
