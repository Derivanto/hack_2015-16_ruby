class Object

	def blank?
		return true if self == nil or self == false

		return true if self.is_a? String and ( self =~ /^\s*$/ )

		return true if self.respond_to? :empty? and self.empty?
		false
	end

	def present?
		!blank?
	end

	def presence
		return self if self.present?
	end

	#def try
	#end

end

asd = ""
#p asd.present?

config = Hash.new("")
config[:host] = 1232
#p config[:host].presence
#p config[:host1].presence

#host = config[:host].presence || 'localhost'