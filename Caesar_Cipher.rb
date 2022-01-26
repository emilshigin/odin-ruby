def ceasor_cipher (phrase, shift)
  new_phrase = phrase.split("").map do |letter|
    if letter == letter.downcase then base = 97 else base = 65 end
    letter = ((((letter.ord - base) + shift) % 26) + base).chr if letter.match(/[a-zA-Z]/)
    letter
  end

  new_phrase.flatten.join
end

p text = ceasor_cipher('Hello_worlD!', 13)

