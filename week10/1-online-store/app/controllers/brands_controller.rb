class BrandsController < ApplicationController
	def show
		if Brand.exists?(params[:index])
    	render json: Brand.find(params[:index])
    else
    	render json: 'brand doesn\'t exist'
    end
  end

  def count
  	render json: Brand.count
  end

  def index
  	render json: Brand.all
  end

  def range
  	render json: Brand.where('id >= ?', params[:id])
  end

  def from
  	render json: Brand.where('id >= ?', params[:id]).first(params[:count])
  end

  def create
  	brand = Brand.new(brand_params)
  	if brand.save
  		render json: brand, status: :created  #201
  	else
  		render json: brand.errors, status: :unprocesssable_entity
  	end
  end

  def destroy
  	return render json: 'brand doesn\'t exist' unless Brand.exists?(params[:id])
    
	  brand = Brand.find(params[:id])
	  brand.destroy

	  if brand.destroyed?
  		render json: brand
  	else
  		render json: brand.errors, status: :unprocesssable_entity
  	end	  
	end

  private
  
  def brand_params
  	params.require(:brand).permit(:name, :description)
  end

end


#postman for mozzila

#{
#"name": "brand",
#"description": "i'm a new brand"
#}

#{
#"name": "category 1"
#}

#{
#"name": "product 1",
#"brand_id": "1",
#"category_id": "1",
#"price": "123",
#"quantity_of_stock": "100"
#}