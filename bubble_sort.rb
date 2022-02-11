def bubble_sort!(array)
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

def bubble_sort_recursive!(array, itterator = 0)
  chaged = false
  for j in 0...array.length-1-itterator do
    temp = array[j]
    if array[j] > array[j+1]
      array[j] = array[j+1]
      array[j+1] = temp
      chaged = true
    end
  end
  bubble_sort_recursive!(array, itterator+1) if chaged
  array 
end

def test_speed(function)
  start_time = Time.now
  function
  end_time = Time.now
  end_time-start_time
end

#arr = [54,3,3464,2342526,634,236,9786,534,7532,432,658,523435,568,444,96,45567,865,756,3453,456423534,545,7567,355365857,456347468,447645]

average_time_norm = 1.0e-06
average_time_rec = 5.0e-07

for i in 0..10000
  arr = ["pug", "beagle", "labrador", "poodle", "golden retriever", "pitbull", "pomeranian", "chihuahua", "shiba inu"]
  arr_2 = arr.dup
  test_1 = test_speed(bubble_sort!(arr))
  test_2 = test_speed(bubble_sort_recursive!(arr_2))
  average_time_norm = (average_time_norm + test_1)/(2)
  average_time_rec = (average_time_rec + test_2)/(2)

end
puts "Bubble sort using 2 for loops: \t#{average_time_norm}\nBubble sort using recurion: \t#{average_time_rec}"
p average_time_norm <=> average_time_rec
# > Using recursion: seems to be faster than using 2 for loops method in all cases.