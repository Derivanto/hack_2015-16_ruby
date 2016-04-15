class CategoriesController < ApplicationController
	def show
		if Category.exists?(params[:index])
    	render json: Category.find(params[:index])
    else
    	render json: Category.find(params[:index]).errors, status: :unprocesssable_entity
    end
  end

  def count
  	render json: Category.count
  end

  def index
  	render json: Category.all
  end

  def range
  	render json: Category.where('id >= ?', params[:id])
  end

  def from
  	render json: Category.where('id >= ?', params[:id]).first(params[:count])
  end

  def create
  	category = Category.new(category_params)
  	if category.save
  		render json: category, status: :created  #201
  	else
  		render json: category.errors, status: :unprocesssable_entity
  	end
  end

  def destroy
  	return render json: Category.find(params[:id]).errors, status: :unprocesssable_entity unless Category.exists?(params[:id])
    
	  category = Category.find(params[:id])
	  category.destroy

	  if category.destroyed?
  		render json: category
  	else
  		render json: category.errors, status: :unprocesssable_entity
  	end	  
	end

  private
  
  def category_params
  	params.require(:category).permit(:name)
  end

end