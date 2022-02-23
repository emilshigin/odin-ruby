module Display
    
    #Large text  display 
    def start_menu 
        <<-_EOF_ 
        Start Menu
####################################################################################################
1) Player Guess Combo
2) Computer Guess Combo
3) Rules
4) Exit
####################################################################################################
        _EOF_
    end
    
    def rules_message 
        <<-_EOF_
####################################################################################################
                                        Welcome to Mastermind!
Objective of the game:
    - Create the secret code and have a computer guess it.
    - Guess a 4 color combination in the correct order
    
Color Options:  \e[41;30m  1  \e[0m \e[42;30m  2  \e[0m \e[43;30m  3  \e[0m \e[44;30m  4  \e[0m \e[45;30m  5  \e[0m \e[46;30m  6  \e[0m \e[47;30m  7  \e[0m

Each guess gets a hint: 
    \e[37m\u25CB\e[0m A blank circle means you found a correct color but not in the correct place
    \e[38m\u25CF\e[0m A filled cicle means you have the correct color in the correcct place

####################################################################################################
_EOF_
    end

# Map symboles for output
    def color_maping(number)
        {
            "1" => "\e[41;30m  1  \e[0m",
            "2" => "\e[42;30m  2  \e[0m",
            "3" => "\e[43;30m  3  \e[0m",
            "4" => "\e[44;30m  4  \e[0m",
            "5" => "\e[45;30m  5  \e[0m",
            "6" => "\e[46;30m  6  \e[0m",
            "7" => "\e[47;30m  7  \e[0m"
        }[number]
    end

    def hint_maping(symble)
        {
            '*' => "\e[38m\u25CF\e[0m", #Exact
            "?" => "\e[91m\u25CB\e[0m" #Almost
        }[symble]
    end

# Printing symbols
    def print_color(array)
        array.each {|num| print color_maping(num.to_s)}
    end

    def print_hint(exact,almost)
        exact.times {|color| print hint_maping('*')}
        almost.times {|color| print hint_maping('?')}
    end

#Draw user Input
    def user_input
        print "\e[32m"
        print ">: "
        input = gets.chomp.downcase
        print "\e[0m"
        input
    end

# Check player color combo input
    def pick_check_color
        secret_combo = user_input
        puts "#{secret_combo.match(/^[1-7]{4}$/) != nil}"
        return secret_combo if secret_combo.match(/^[1-7]{4}$/) != nil
        puts "\e[31mOne or more of the choosen colors do not exist.\e[0m" if secret_combo.match(/^[1-7]{1,}$/) == nil 
        puts "\e[31mRemember the combo length needs to be 4 colors.\e[0m" if secret_combo.match(/^[0-9]{4}$/) == nil
        print "Please enter a correct combo:"
        pick_check_color
    end

end

# Computer Guesses User Pick Color Combo
    def player_pick_color
        system 'clear' or 'cls'
        print "Color Options: "
        print_color((1..7))
        puts "\nPlease enter a color Combo:"
        secret_combo = pick_check_color
        print_color(secret_combo.split(""))
        secret_combo
    end

# End Game Screen 
    def win_screen(resualt)
        puts "\n\n"
        puts "###############################"
        puts "#         You won!            #" if resualt == "win"
        puts "#        You lost!            #" if resualt == "lose"
        puts "###############################"
        puts "\n"
    end