def bubble_sort(array)
  for i in 0...array.length-1 do
    for j in 0..array.length-2-i do
      temp = array[j]
      if array[j] > array[j+1]
        array[j] = array[j+1]
        array[j+1] = temp
      end
    end
  end
  array
end

def bubble_sort_recursive(array, itterator = 0)
  chaged = false
  for j in 0...array.length-1-itterator do
    temp = array[j]
    if array[j] > array[j+1]
      array[j] = array[j+1]
      array[j+1] = temp
      chaged = true
    end
  end
  bubble_sort_recursive(array, itterator+1) if chaged
  array 
end

#arr = ["pug", "beagle", "labrador", "poodle", "golden retriever", "pitbull", "pomeranian", "chihuahua", "shiba inu"]
arr = [54,3,3464,2342526,634,236,9786,534,7532,432,658,523435,568,444,96,45567,865,756,3453,456423534,545,7567,355365857,456347468,447645]
arr_2 = arr.dup

p "arr:   "+arr.to_s
start_1 = Time.now
p "sorted:"+bubble_sort(arr).to_s
end_1 = Time.now

p "arr_2: "+arr_2.to_s
start_2 = Time.now 
p "sorted:"+bubble_sort_recursive(arr_2).to_s
end_2 = Time.now

puts "Bubble sort using 2 for loops: \t#{end_1-start_1}\nBubble sort using recurion: \t#{end_2-start_2}"