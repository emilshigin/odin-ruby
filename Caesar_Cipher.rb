def ceasor_cipher (phrase, shift)
  new_phrase = ""
  phrase.split("").map do |letter|
    if letter.match(/[a-z]/)
      shift.times do 
        if letter == "z"
        letter = "a"
        else
          letter = letter.next
        end
      end
      
    elsif letter.match(/[A-Z]/)
      shift.times do 
        if letter == "Z"
            letter = "A"
        else
          letter = letter.next
        end
      end
    end
    new_phrase = new_phrase+letter  
  end
  return p new_phrase
end

text = ceasor_cipher('What a string!',5)