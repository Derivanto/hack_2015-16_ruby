def fact(n)
	return 1 if n == 0
  1.upto(n).reduce { |a, e| a * e }
end

def nth_lucas(n)
  a, b = 2, 1

  2.upto(n) { a, b = b, a + b }

  a
end

def first_lucas(n)
  1.upto(n).map { |index| nth_lucas index }
end

def to_digits(n)
  n.to_s.chars.map { |d| d.to_i }
end

def count_digits(n)
  to_digits(n).length
end

def sum_digits(n)
  to_digits(n).reduce { |a, e| a + e }
end

def factorial_digits(n)
  to_digits(n)
    .map { |d| fact d }
    .reduce { |a, e| a + e }
end

def first_fibs(n)
  a, b = 1, 1
  result = [a]

  2.upto(n) do
    a, b = b, a + b
    result << a
  end

  result
end

def fib_number(n)
  first_fibs(n).join('').to_i
end

def hack?(n)
  bn = n.to_s 2
  bn.count('1').odd? && bn.reverse == bn
end

def next_hack(n)
  n = n.next
  n = n.next until hack? n
  n
end

def count_vowels(str)
  str.downcase.scan(/[aeiouy]/).count
end

def count_consonants(str)
  str.downcase.scan(/[bcdfghjklmnpqrstvwxz]/).count
end

def palindrome?(object)
  object.to_s.reverse == object.to_s
end

def p_score(n)
  return 1 if palindrome? n

  1 + p_score(n + n.to_s.reverse.to_i)
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

def char_is_positive_digit?(n)
  123_456_789_0.to_s.chars.include? n
end

def sum_of_numbers_in_string(str)
  result = 0
  chars = str.chars

  while chars.length > 0
    ns = chars.take_while { |ch| char_is_positive_digit? ch }
    result += ns.join('').to_i

    if ns.length == 0
      chars = chars.drop_while { |ch| !char_is_positive_digit? ch }
    else
      chars = chars.drop(ns.length)
    end
  end

  result
end

def anagrams?(a, b)
  a.delete(' ').downcase.chars.sort == b.delete(' ').downcase.chars.sort
end

def balanced?(n)
  n = n.to_s
  mid = n.length / 2

  left_part = n.slice(0, mid)
  right_part = n.slice(mid + n.length % 2, n.length)

  sum_digits(left_part.to_i) == sum_digits(right_part.to_i)
end

def zero_insert(n)
	n_str = n.to_s
	i=0

	while i < n_str.length-1 do
		if (n_str[i] == n_str[i+1]) || ((n_str[i].to_i + n_str[i+1].to_i) % 10 == 0) 
			n_str.insert(i+1, '0')
		end
		i+=1
	end

n_str.to_i
end


p first_primes(1000)