def number_to_digits(n)
  n.to_s.chars.map(&:to_i)
end

def digits_to_number(digits)
  digits.reduce(0) { |a, e| a * 10 + e }
end

def grayscale_histogram(image)
  histogram = Array.new 256, 0
  row_index, col_index = 0, 0

  while row_index < image.length
    col_index = 0

    while col_index < image[row_index].length
      pixel_value = image[row_index][col_index]
      histogram[pixel_value] += 1
      col_index += 1
    end

    row_index += 1
  end

  histogram
end

def max_scalar_product(v1, v2)
  v1 = v1.sort
  v2 = v2.sort

  v1.each_with_index
    .map { |x, i| x * v2[i] }
    .reduce(&:+)
end

def max_from_arr(items)
  i=1
  index=0
  max = items[0]
  while i < items.length
    if max<items[i]
      max = items[i] 
      index = i
    end

    i+=1
  end
  max
end

def max_span(numbers)
  i, j, k = 0, numbers.length-1, 0
  span = []

  return 1 if numbers.length==1

  while i < numbers.length
    j=numbers.length-1
    while j > 0 
      if numbers[i] == numbers[j]
        span[k] = j-i+1
        k+=1 
      end
      j-=1
    end
    i+=1
  end
  max_from_arr(span)
end

def sum_matrix(m)
  m.map { |row| row.reduce(&:+) }.reduce(&:+)
end

def neighbours_to_cell(x,y)
  [ [x-1, y-1], [x, y-1], [x+1, y-1], [x+1, y], [x+1, y+1], [x, y+1], [x-1, y+1], [x-1, y] ]
end

def matrix_bombing_plan(matrix)
  i, j = 0, 0
  temp_m = Array.new(3, Array.new(3, 0)) 
  bombing_hash = Hash.new

  while i < matrix.length
    j=0
    while j < matrix[0].length
      temp_m = Marshal.load(Marshal.dump(matrix))

      neighbours_to_cell(i,j).each do |index|
        if (0..2)===index[0] and (0..2)===index[1]
          temp_m[index[0]][index[1]] -= temp_m[i][j] 
          temp_m[index[0]][index[1]] = 0 if temp_m[index[0]][index[1]] < 0
        end
      end

      bombing_hash[[i,j]] = sum_matrix(temp_m)
      j+=1
    end
    i+=1
  end

bombing_hash
end

def group(items)
  result = []
  
  i, j, k = 0, 0, 0

  while i < items.length
    if items[i] == items[i+1]
      i+=1
    else
      result[k] = items[j..i]
      j=i+1
      k+=1
      i+=1
    end
  end
result
end

def max_consecutive(items)
  i=1
  res = group(items)
  max = res[0].length

  while i < res.length
    max = res[i].length if max < res[i].length
    i+=1
  end
max
end