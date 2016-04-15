module Search

	def self.by_type_and_slug(params)
		case params[:type]
		when 'categories'
			Category.where('name LIKE ?', "%#{params[:slug]}%")
		when 'products'
			Product.where('name LIKE ?', "%#{params[:slug]}%")
		when 'brands'
			Brand.where('name LIKE ?', "%#{params[:slug]}%")
		end
	end

	def self.by_type_property_and_slug(params)
		case params[:type]
		when 'categories'
			Category.where('? LIKE ?', "#{params[:property]}", "%#{params[:slug]}%")
		when 'products'
			Product.where('? LIKE ?', "#{params[:property]}", "%#{params[:slug]}%")
		when 'brands'
			Brand.where("#{params[:property]} LIKE ?", "%#{params[:slug]}%")
			#Brand.where('? LIKE ?', "#{params[:property]}", "%#{params[:slug]}%")
		end
	end

end