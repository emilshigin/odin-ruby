def substrings(message, dictionary)
  message_ary = message.split(' ').map do |word| word.gsub(/[^\w]/,'').downcase end
  res = message_ary.reduce(Hash.new(0)) do |object, word|
    dictionary.each { |element| object[element] += 1 if word.include? (element) }
    object
  end
  res
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
message = "Howdy partner, sit down! How's it going?"
p substrings(message, dictionary) # {"down"=>1, "go"=>1, "going"=>1, "how"=>1, "howdy"=>1, "it"=>1, "i"=>1, "own"=>1, "part"=>1, "partner"=>1, "sit"=>1}

message = "below"
p substrings(message, dictionary) # {"below"=>1, "low"=>1}