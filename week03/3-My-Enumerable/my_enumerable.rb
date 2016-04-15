# Implementation of our own Enumerable class
module MyEnumerable
 
  def map
    return enum_for(:map) unless block_given?
    Array.new.tap do |arr|
      each do |element|
        value = yield element
        arr << value
      end
    end
  end

  def filter
    return enum_for(:filter) unless block_given?
    Array.new.tap do |arr|
      each do |element|
        arr << element if (yield element)
      end
    end
  end

  def reject
    return enum_for(:reject) unless block_given?
    Array.new.tap do |arr|
      each do |element|
        arr << element unless (yield element)
      end
    end
  end

  def first
    element = nil
    each do |x|
      element = x
      break
    end
    element
  end

  def reduce(initial = nil)
    skip_first = false
    if initial == nil
      initial = self.first 
      skip_first = true
    end
    each do |element|
      if skip_first
        skip_first = false
        next
      end
      initial = yield initial, element
    end
    initial
  end

  def any?
    each do |element|
      return true if yield element
    end
  end

  def all?
    each do |element|
      return false unless yield element
    end
  end

  def include?(element)
    each do |collection_elem|
      return true if element == collection_elem
    end
  end

  def count(element = nil)
    if element != nil #if element is given
      sum=0
        each do |coll_elem|
          sum+=1 if element == coll_elem
        end 
      sum
    elsif block_given? #if block is given
      sum=0
        each do |coll_elem|
          sum+=1 if yield coll_elem 
        end
      sum
    else #just count size
      self.size
    end
  end

  def size
    sum=0
      each do |element|
        sum+=1
      end
    sum
  end

  def min
    if block_given?

    else 
      result = self.get(0)
        reduce do |result, element|
          if result > element
            element
          else result
          end
        end
      result
    end

  end

  def min_by
    result = (yield self.get(0))
    res_el = self.get(0)
      each do |element|
        if result > (yield element)
          result = yield element
          res_el = element
        end
      end
    res_el
  end

  def max
    result = self.get(0)
        each do |element|
          result = element if result < element
        end
      result
  end

  def max_by
    result = (yield self.get(0))
    res_el = self.get(0)
      each do |element|
        if result < (yield element)
          result = yield element
          res_el = element
        end
      end
    res_el
  end

  def take(n)
    n = self.size if n > self.size
    Array.new.tap do |arr|
      (0..n-1).each do |index|
        arr << self.get(index)
      end
    end
  end

  def take_while
    Array.new.tap do |arr|
      each do |element|
        break unless (yield element)
        arr << element
      end
    end
  end

  def drop(n)
    n = self.size if n > self.size

    Array.new.tap do |arr|
      (n..self.size-1).each do |index|
        arr << self.get(index)
      end
    end
  end

  def drop_while(&block)

    n = take_while(&block).count
    Array.new.tap do |arr|
      (n..self.size-1).each do |index| 
        arr << self.get(index)
      end
    end
  end

end


