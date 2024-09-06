class FoodsController < ApplicationController
  def index
    @foods = FoodSearchFacade.search(params[:ingredient])
    @total_results = FoodSearchFacade.total_results(params[:ingredient])
  end
  #   ingredient = params[:ingredient]
  #   if ingredient.present?
  #     response = Faraday.get("https://api.nal.usda.gov/fdc/v1/foods/search") do |req|
  #       req.params['api_key'] = Rails.application.credentials.usda[:api_key]
  #       req.params['query'] = ingredient
  #       req.params['pageSize'] = 10
  #     end

  #     data = JSON.parse(response.body)
  #     @foods = data['foods']
  #     @total_results = data['totalHits']
  #   else
  #     @foods = []
  #     @total_results = 0
  #   end
  # end
end
