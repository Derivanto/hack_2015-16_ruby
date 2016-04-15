class SearchesController < ApplicationController
	def search_by_type
		result = Search.by_type_and_slug(search_params)
		render json: result
	end

	def search_by_type_and_property
		result = Search.by_type_property_and_slug(search_params)
		render json: result
	end

	private

	def search_params
		params.permit(:type, :slug, :property)
	end
end