def ceasor_cipher (phrase, shift)
  new_phrase = ""
  phrase.split("").map do |letter|
    if letter.match(/a-zA-Z/) || letter == letter.downcase then base = 97 else base = 65 end
      letter = ((((letter.ord - base) + shift) % 26) + base).chr
    new_phrase = new_phrase+letter  
  end
    
  return new_phrase
end

p text = ceasor_cipher('What a string y HelloWorld!',-25)

