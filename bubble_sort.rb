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

p bubble_sort([5,64,3,46,1])