class NumberSet
	include Enumerable

	attr_reader :numbers

	def initialize
		@numbers = []
	end

	def each(&block)
      @numbers.each(&block)
    end

#Fixnum, Float, Rational и Complex
	def <<(value)
		@numbers << value unless @numbers.include? value
	end

	def size
		@numbers.length
	end

	def empty?
		@numbers.size == 0
	end

	def [](filters)
		filtered_numbers = NumberSet.new
			numbers.each { |value| filtered_numbers << value if filters.filter(value) }
		filtered_numbers
	end

end

module Operators

	def &(other)
		Filter.new { |value| self.filter(value) and other.filter(value) }
	end

	def |(other)
		Filter.new { |value| self.filter(value) or other.filter(value) }
	end

end

class Filter
	include Operators

	def initialize(&block)
		@block = block
	end

	def filter(value)
		@block.call value
	end

end

class TypeFilter
	include Operators

	def initialize(type)
		@type = type
	end

	def filter(value)
		case @type
		when :integer then value.is_a? Integer
		when :real then value.is_a? Float or value.is_a? Rational
		when :complex then value.is_a? Complex
		end
	end

end

class SignFilter
	include Operators

	def initialize(sign)
		@sign = sign
	end

	def filter(value)
		case @sign
		when :positive then value > 0
		when :non_positive then value <= 0
		when :negative then value < 0
		when :non_negative then value >= 0
		end
	end

end



asd = NumberSet.new
#p asd.numbers
asd << 5
#p asd.numbers
asd << 5 + 0i
p asd.numbers
p asd.size
asd2 = NumberSet.new
p asd2.empty?
asd2 << 10
p asd2.empty?

puts "\ntest Filter even?"
asd4 = NumberSet.new
[-3, -2, -1, 0, 1, 2, 3, 4, 5].each { |number| asd4 << number }
p asd4.numbers
p asd4[ Filter.new { |number| number.even? } ].to_a

puts "\ntest TypeFilter :complex"
asd3 = NumberSet.new
[-3, -2, 2 + 22i, -1, 0, 1, 2, 3, 4, 5, 5 + 5i].each { |number| asd3 << number }
p asd3.numbers
p asd3[ TypeFilter.new ( :complex ) ].to_a

puts "\ntest SignFilter :non_negative"
asd5 = NumberSet.new
[-3, -2, -1, 0, 1, 2, 3, 4, 5].each { |number| asd5 << number }
p asd5.numbers
p asd5[ SignFilter.new ( :non_negative ) ].to_a

puts "\ntest SignFilter :positive and Filter even?"
p asd4.numbers
p asd4[ SignFilter.new(:positive) & Filter.new { |number| number.even? } ].to_a

