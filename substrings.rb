def substrings(message, dictionary)
  message_ary = message.split(' ').map do |word| word.gsub(/[^\w]/,'').downcase end
  message_ary = message_ary.join(' ')
  res = dictionary.reduce(Hash.new(0)) do |word, count|
    word[count] += 1 if  message_ary.include? count
    word
  end
  res
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
message = "Howdy partner, sit down! How's it going?"
p substrings(message, dictionary) # {"down"=>1, "go"=>1, "going"=>1, "how"=>1, "howdy"=>1, "it"=>1, "i"=>1, "own"=>1, "part"=>1, "partner"=>1, "sit"=>1}

message = "below"
p substrings(message, dictionary) # {"below"=>1, "low"=>1}