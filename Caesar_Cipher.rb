def ceasor_cipher (phrase, shift)
  new_phrase = phrase.split("").map do |letter|
    if letter == letter.downcase then base = 97 else base = 65 end
    letter = ((((letter.ord - base) + shift) % 26) + base).chr if letter.match(/[a-zA-Z]/)
    letter
  end
  return new_phrase.flatten.join
end

p ceasor_cipher('Hello_worlD!', 13)
p ceasor_cipher('Krispy Treats need to keep secret', -103)

