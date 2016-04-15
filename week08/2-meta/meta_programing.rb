#p Object.new.singleton_class 
#p String.singleton_class 
#p nil.singleton_class 

class Object
  def singleton_class
    class << self
      self
    end
  end
end

#p Object.new.singleton_class 
#p String.singleton_class 
#p nil.singleton_class 


class Object

  #def define_singleton_method(name, method = nil, &block)
  # class << self
  #   main.define_method(name, method, &block)
  # end
  #end

end
asd = Object.new
#asd.define_singleton_method()

class String
  def to_proc
    lambda do |object, *args|

      asd = self.split('.')
      asd.each do |function|
        object = object.public_send(function.to_sym, *args)
      end

      object
    end
  end
end

p [2, 3, 4, 5].map(&'succ.succ')

module Accesors
  def private_attr_accessor(*names)
    private
    attr_accessor *names
  end

  def protected_attr_accessor(*names)
    protected
    attr_accessor *names
  end

  def private_attr_reader(*names)
    private
    attr_reader *names
  end

  def private_attr_reader2(*attrs)
    attrs.each do |attrr|
      define_method(attrr) do
        instance_variable_get("@#{attrr}")
      end
      private attrr
    end
  end

  def protected_attr_reader(*names)
    protected
    attr_reader *names
  end

  def private_attr_writer(*names)
    private
    attr_writer *names
  end

  def protected_attr_writer(*names)
    protected
    attr_writer *names
  end

  def cattr_reader(*names)
    names.each do |name|
      define_singleton_method(name) do
        class_variable_get("@@#{name}")
      end
    end
  end

end

class Test
  extend Accesors
  
  private_attr_reader2 :instance_var
  cattr_reader :class_var


  @@class_var = 'asd'
  @instance_var = 'sdfg'

end

test = Test.new
test.instance_variable_set("@instance_var", '1231')
#p test.instance_var
#p Test.private_instance_methods
#p Test.instance_methods 

Test.class_variable_set("@@class_var", '5555')
p Test.class_var

#def first_name(*args, &block)
# @user.first_name(*args, &block)
#end

class Module
  def delegate (name, to:)
    instance_eval do
      define_method(name) do |*args, &block|
        instance_variable_get(to).send(name)
      end
    end
  end
end

User = Struct.new(:first_name, :last_name)
user = User.new 'Genadi', 'Samokovarov'
#p user.first_name


class Invoce
  delegate :first_name, to: '@user'
  delegate :last_name, to: '@user'

  def initialize(user)
    @user = user
  end
end

invoice = Invoce.new(user)
p invoice.first_name
p invoice.last_name

class Fixnum
  old_mult = instance_method(:*)

  define_method(:*) do |number|
    if (number == 6 and self == 9) or (number == 9 and self == 6)
      42
    else old_mult.bind(self).(number)
    end
  end
end

#p 6*9
#p 9*6
#p 9*7
end
