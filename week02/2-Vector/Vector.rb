class Vector
  def initialize(*components)
    @components = components.flatten
  end

  def components
    @components
  end

  def dimension
    @components.length
  end

  def length
    sum=0
    @components.each {|comp| sum+=comp*comp}
    Math.sqrt(sum)
  end

  def normalize
    length=self.length
    @components.each_index {|index| @components[index]/=length}
  end

  def [](index)
    @components[index]
  end

  def []=(index, value)
    @components[index]=value
  end

  def ==(other)
    bool=true
    #check dimension
    @components.zip(other.components).each do |comp, other_comp| 
      bool=false if comp != other_comp
    end
    bool
  end

  def +(vector_of_same_dimension_or_scalar)
    
    #if vector and same dimension
    if vector_of_same_dimension_or_scalar.class == Vector and self.dimension == vector_of_same_dimension_or_scalar.dimension
      vector = Vector.new
      @components.zip(vector_of_same_dimension_or_scalar.components).each_with_index do |(comp1, comp2),index|
        vector[index] = comp1 + comp2
      end
      vector
    else puts "error"
    end

  end

  def -(vector_of_same_dimension_or_scalar)
     if vector_of_same_dimension_or_scalar.class == Vector and self.dimension == vector_of_same_dimension_or_scalar.dimension
      vector = Vector.new
      @components.zip(vector_of_same_dimension_or_scalar.components).each_with_index do |(comp1, comp2),index|
        vector[index] = comp1 - comp2
      end
      vector
    else puts "error"
    end

  end

  def *(scalar)
    if scalar.is_a? Numeric
      Vector.new @components.map {|comp| comp*scalar}
      #vector = Vector.new
      #@components.each_with_index {|comp, index| vector[index] = comp*scalar}
      #vector
    else puts "error"
    end
  end

  def /(scalar)
    if scalar.is_a? Numeric
      Vector.new @components.map {|comp| comp/scalar.to_f}
      #vector = Vector.new
      #@components.each_with_index {|comp, index| vector[index] = comp/scalar.to_f}
      #vector
    else puts "error"
    end
  end

  def dot(vector_of_same_dimension_or_scalar)
    # Return the dot product of the two vectors
    # https://en.wikipedia.org/wiki/Dot_product#Algebraic_definition
  end

  def to_s
    puts "#{@components}"
  end
end

vector1 = Vector.new(1, 2, 3, 4)
vector1.to_s
vector2 = Vector.new( [3, 5, 7, 2] )
vector2.to_s
puts "#{vector1.dimension}"
puts "#{vector1.length}"
vector1.normalize
vector1.to_s

puts vector1.[]2
vector1.[]= 2, 4
vector1.to_s

vector3 = Vector.new(1, 2, 3, 4)
vector4 = Vector.new(1, 2, 3, 4)
puts vector3 == vector4

vector5 = Vector.new
vector5 = vector4 + vector2
vector5.to_s

vector6 = Vector.new
vector6 = vector4 - vector2
vector6.to_s

vector7 = Vector.new
vector7 = vector5 * 3
vector7.to_s

vector8= Vector.new
vector8 = vector5 / 3
vector8.to_s





# git pull origin master
# gem install bundle
# cd do gem file
# bundle install
