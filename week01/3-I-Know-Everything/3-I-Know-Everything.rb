def numbers_to_message(message)
	buttons = [ ['a','b','c'], ['d','e','f'], ['g','h','i'], ['j','k','l'], 
		 		['m','n','o'], ['p','q','r','s'], ['t','u','v'], ['w','x','y','z'] ]
	button, times_pressed, i = 0, 1, 0
	result = ""
	capital = false

	while i < message.length
		if message[i] == 1
			capital=true
			i+=1
			next
		elsif message[i] == 0
			result += ' '
			i+=1
			next
		end

		button = message[i]
		if message[i] == message[i+1]
			times_pressed += 1
		else 
			if capital
				result += buttons[ button-2 ] [ (times_pressed % buttons[button-2].length)-1 ].upcase
				capital = false
			else result += buttons[ button-2 ] [ (times_pressed % buttons[button-2].length)-1 ] 
			end
			times_pressed = 1
		end
		i+=1 if message[i+1] == -1	
		i+=1
	end

result
end


def message_to_numbers(message)
	buttons = [ ['a','b','c'], ['d','e','f'], ['g','h','i'], ['j','k','l'], 
		 		['m','n','o'], ['p','q','r','s'], ['t','u','v'], ['w','x','y','z'] ]
	result = []
	i, j, m, r = 0, 0, 0, 0
	breaking = false

	while m < message.length
		
		if message[m] == ' '
			result[r] = 0
			r+=1
			m+=1
			next
		elsif message[m] === message[m].upcase
			message[m] = message[m].downcase
			result[r] = 1
			r+=1
		end

		i=0
		while i < buttons.length
			j=0
			while j < buttons[i].length
				if message[m] == buttons[i][j] 
				
					if ((result[r-1] == i+2))
						result[r] = -1
						r+=1
					end

					while j+1>0 
						result[r] = i+2
						r+=1
						j-=1
					end

					breaking = true
					break
				end
				j+=1
			end

			if breaking
				breaking = false
				break
			end
			i+=1
		end

		m+=1
	end

result
end

def prepare_meal(number)
	result = ''

	while (number % 3 == 0) or (number % 5 == 0)
		if (number % 3) == 0
			result += "spam"
			number /= 3
		elsif (number % 5) == 0
			if result == ''
				result += "eggs" 
			else
				result += "and eggs"
			end
			number /= 5
		end
		result += ' ' if (number % 3 == 0) or (number % 5 == 0)
	end
result
end

def reduce_file_path(path)
i=0
result = ""
	while i < path.length
		if path[i..i+1] == "//"
			path = path[0..i] + path[i+2..path.length]
			i-=1
		elsif path[i..i+1] == ".."
			j=i-2
			if j > 1
				while path[j] != "/"
					j-=1
				end
			else j=i-1
			end
			path = path[0..j] + path[i+3..path.length]
			i=j-1
		elsif path[i] == '.'
			path = path[0..i-1] + path[i+1..path.length]
			i-=2
		end

		i+=1
	end
	path = path[0..path.length-2] if path.length > 0 and path[path.length-1]=="/"
path
end

def an_bn?(word)
	if (word.length % 2) != 0
		false
	else
		i=0
		while i < word.length/2
			return false if word[i] != 'a'
			i+=1
		end
		i = word.length/2 + 1
		while i < word.length
			return false if word[i] != 'b'
			i+=1
		end
		true
	end
end

def valid_credit_card?(number)
	str=number.to_s
	if (str.length % 2) == 0
		false
	else
		i = 0
		sum = 0
		while i < str.length
			if i%2 != 0
				sum += str[i].to_i*2
			else sum+=str[i].to_i
			end
			i+=1
		end
		if sum % 10 == 0
			true
		else false
		end
	end
end

def prime?(n)
  return false if n < 2
  2.upto(n/2).all? { |i| n % i != 0 }
end

def first_primes(n)
  return false if n < 2
  Array.new.tap do |arr|
  	2.upto(n) { |i| arr << i if prime?(i) } 
  end
end

def goldbach(number)
	return "number must be greater then 2 and even" if number < 2 or number % 2 != 0
	primes = first_primes(number)
	list = []

	0.upto(primes.length) do |i|
		i.upto(primes.length-1) do |j|
			list << [primes[i], primes[j]] if primes[i] + primes[j] == number
		end
	end

	list
end

def magic_square?(matrix)
	magic_number = matrix.first.reduce(&:+)
	row_sum, d1_sum, d2_sum = 0, 0, 0
	col_sum = Array.new(matrix.length, 0)

	matrix.each_index do |i|
		matrix.each_index do |j|
			row_sum += matrix[i][j]
			col_sum[j] += matrix[i][j]
			if i == j 
				d1_sum += matrix[i][j]
				temp = matrix[i].reverse
				d2_sum += temp[i]
			end
		end
		return false if row_sum != magic_number
		row_sum = 0 
	end

	return false if d1_sum != magic_number or d2_sum != magic_number

	col_sum.all? {|number| number == magic_number}
end
