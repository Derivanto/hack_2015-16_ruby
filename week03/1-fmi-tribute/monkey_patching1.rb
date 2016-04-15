class Array

  def to_hash
    hash = Hash.new
    self.each { |element| hash[element[0]] = element[1] }
    hash

    #inject(Hash.new) { |hash, (key,value)| hash[key] = value; hash}
  end

  def index_by
    hash = Hash.new
    self.each { |element| hash[yield element] = element }
    hash
  end

  def subarray_count(subarray)
    return 0 if subarray.length == 0
    count = 0
    self.each_cons(subarray.length) {|arr| count+=1 if arr == subarray}
    count
  end

  def occurences_count
    hash = Hash.new(0)
    self.each {|element| hash[element] += 1}
    hash
  end

end


#Tests
puts
p [[:one, 1], [:two, 2]].to_hash
p [[1, 2], [3, 4]].to_hash 
p [[1, 2], [1, 3]].to_hash
p [].to_hash
puts
p ['John Coltrane', 'Miles Davis'].index_by { |name| name.split(' ').last }
p %w[foo larodi bar].index_by { |s| s.length }
puts
p [1, 2, 3, 2, 3, 1].subarray_count([2, 3])
p [1, 2, 2, 2, 2, 1].subarray_count([2, 2])
p [1, 1, 2, 2, 1, 1, 1].subarray_count([1, 1]) 
puts
p [:foo, :bar, :foo].occurences_count 
p %w[a a b c b a].occurences_count   
puts
