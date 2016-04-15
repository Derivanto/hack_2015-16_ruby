class ProductsController < ApplicationController
	def show
		if Product.exists?(params[:index])
    	render json: Product.find(params[:index])
    else
    	render json: 'product doesn\'t exist'
    end
  end

  def count
  	render json: Product.count
  end

  def index
    render json: Product.all
    #render json: Brand.joins(:products).select('brands.name')

    #  Products   ('id, name, brand_id, category_id, price, quantity_of_stock')

    #render json: Brand.joins(:products).select("products.id, products.name, brands.name AS brand, price, quantity_of_stock")
    #render json: Category.joins(:products).select("categories.name AS category")

    #render json: Product.joins("JOIN brands ON brand_id = brands.id").select("products.name AS product, brands.name AS brand")
  end

  def range
  	render json: Product.where('id >= ?', params[:id])
  end

  def from
  	render json: Product.where('id >= ?', params[:id]).first(params[:count])
  end

  def create
    #@article = Article.find(params[:article_id])
    #@comment = @article.comments.create(comment_params)
    
    #brand = Brand.find(params[:brand_id])
    #category = Category.find(params[:category_id]) 
    #product = brand&category.products.new(product_params)


  	product = Product.new(product_params)
  	if product.save
  		render json: product, status: :created#, location: product  #201
  	else
  		render json: product.errors, status: :unprocesssable_entity
  	end
  end

  def destroy
  	return render json: 'product doesn\'t exist' unless Product.exists?(params[:id])
    
	  product = Product.find(params[:id])
	  product.destroy

	  if product.destroyed?
  		render json: product
  	else
  		render json: product.errors, status: :unprocesssable_entity
  	end	  
	end

  private
  
  def product_params
  	params.require(:product).permit(:name, :brand_id, :category_id, :price, :quantity_of_stock)
  end

end


#render json: Product.select('id, name, brand_id, category_id, price, quantity_of_stock')
#render json: Brand.joins(:products).select('brand.name')