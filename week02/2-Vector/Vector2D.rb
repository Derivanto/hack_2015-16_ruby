class Vector2D
  def initialize(x, y)
    @x, @y = x, y
  end

  def x
    @x
  end

  def x=(value)
    @x = value
  end

  def y
    @y
  end

  def y=(value)
    @y = value
  end

  def length
    Math.sqrt(@x*@x + @y*@y)
  end

  def normalize
    length=self.length
    @x /= length
    @y /= length
  end

  def ==(other)
    if @x == other.x and @y == other.y
      true
    else false
    end
  end

  def +(other)
    Vector2D.new @x+other.x, @y+other.y
  end

  def -(other)
    Vector2D.new @x-other.x, @y-other.y
  end

  def *(scalar)
    Vector2D.new @x*other.x, @y*other.y
  end

  def /(scalar)
    Vector2D.new @x.to_f/other.x, @y.to_f/other.y
  end

  def dot(other)
    @x*other.x + @y*other.y
  end

  def to_s
    puts "(#{@x}, #{@y})"
  end
  
end


vector = Vector2D.new(1,2)
vector.to_s
puts "length = #{vector.length}"

vector.normalize
vector.to_s

vector1 = Vector2D.new(1,2)
vector2 = Vector2D.new(3,4)
vector3 = Vector2D.new(0,0)
vector3 = vector1 + vector2
puts "#{vector3}"

